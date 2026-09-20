import path from 'node:path';

/** @type {import('lint-staged').Config} */
export default {
    '*.{ts,tsx,md,json,js,mjs,cjs}': 'prettier --write --ignore-unknown',
    'apps/admin-dashboard/**/*.{ts,tsx}': (files) => {
        const relativeFiles = files.map((file) => `"${path.relative('apps/admin-dashboard', file)}"`).join(' ');
        return `npm exec --workspace=admin-dashboard -- eslint --fix --max-warnings 0 ${relativeFiles}`;
    },
};
