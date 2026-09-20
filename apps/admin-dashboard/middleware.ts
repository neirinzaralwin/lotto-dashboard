import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { NextResponse, type NextRequest } from 'next/server';

type CookieToSet = {
    name: string;
    value: string;
    options: CookieOptions;
};

function redirectToLogin(request: NextRequest) {
    const redirect = request.nextUrl.clone();
    redirect.pathname = '/login';
    if (request.nextUrl.pathname !== '/') {
        redirect.searchParams.set('next', request.nextUrl.pathname);
    } else {
        redirect.search = '';
    }
    return NextResponse.redirect(redirect);
}

export async function middleware(request: NextRequest) {
    const path = request.nextUrl.pathname;
    const isLogin = path === '/login';

    const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

    // Fail closed: never expose the dashboard without configured auth.
    if (!url || !key) {
        if (!isLogin) return redirectToLogin(request);
        return NextResponse.next();
    }

    let response = NextResponse.next({
        request: { headers: request.headers },
    });

    const supabase = createServerClient(url, key, {
        cookies: {
            getAll() {
                return request.cookies.getAll();
            },
            setAll(cookiesToSet: CookieToSet[]) {
                cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
                response = NextResponse.next({ request: { headers: request.headers } });
                cookiesToSet.forEach(({ name, value, options }) =>
                    response.cookies.set(name, value, options),
                );
            },
        },
    });

    const {
        data: { user },
    } = await supabase.auth.getUser();

    if (!user && !isLogin) {
        return redirectToLogin(request);
    }

    if (user && isLogin) {
        const next = request.nextUrl.searchParams.get('next');
        const redirect = request.nextUrl.clone();
        redirect.pathname = next && next.startsWith('/') && !next.startsWith('//') ? next : '/';
        redirect.search = '';
        return NextResponse.redirect(redirect);
    }

    return response;
}

export const config = {
    matcher: ['/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)'],
};
