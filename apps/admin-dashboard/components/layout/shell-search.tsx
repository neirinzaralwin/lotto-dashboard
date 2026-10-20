'use client';

import {
    createContext,
    useCallback,
    useContext,
    useMemo,
    useState,
    type ReactNode,
} from 'react';
import type { LotteryType } from '@repo/types';

export type ShellSearchNumbers = {
    mains: number[];
};

/** One submitted search (draw number and/or balls). */
export type SearchEntry = { query: string; balls: number[] };

/** How many past searches stay on screen per tab (Reset clears them). */
export const SEARCH_HISTORY_LIMIT = 3;

/** Draw-number query + main-number slots kept per game tab. */
type ShellSearchTabState = {
    /** What is typed — never filters by itself. */
    query: string;
    numbers: ShellSearchNumbers;
    /** What was submitted (Search button / Enter) — drives results. */
    applied: SearchEntry;
    /** Submitted searches, newest first, at most {@link SEARCH_HISTORY_LIMIT}. */
    history: SearchEntry[];
};

type ShellSearchContextValue = {
    /** Draft draw number bound to inputs. */
    query: string;
    setQuery: (value: string) => void;
    /** Submitted draw number — filter with this, not `query`. */
    appliedQuery: string;
    /** Apply the current draft (query + balls). */
    submitSearch: () => void;
    /** True when the draft differs from what was last searched. */
    dirty: boolean;
    searchNumbers: ShellSearchNumbers;
    setSearchNumbers: (next: ShellSearchNumbers) => void;
    activeType: LotteryType;
    setActiveType: (type: LotteryType) => void;
    resetActive: () => void;
    open: boolean;
    setOpen: (open: boolean) => void;
    selectedDrawId: string | null;
    selectDraw: (id: string | null) => void;
    clearSelection: () => void;
    /** Submitted balls. */
    filledBalls: number[];
    hasNumberFilter: boolean;
    /** Last searches of the active tab, newest first (current one included). */
    searchHistory: SearchEntry[];
};

const ShellSearchContext = createContext<ShellSearchContextValue | null>(null);

function emptySlots(type: LotteryType): ShellSearchNumbers {
    const count = type === 'lotto6' ? 6 : 7;
    return { mains: Array.from({ length: count }, () => 0) };
}

function emptyTab(type: LotteryType): ShellSearchTabState {
    return { query: '', numbers: emptySlots(type), applied: { query: '', balls: [] }, history: [] };
}

function collectFilled(numbers: ShellSearchNumbers): number[] {
    return numbers.mains.filter((n) => n > 0);
}

const fallback: ShellSearchContextValue = {
    query: '',
    setQuery: () => undefined,
    appliedQuery: '',
    submitSearch: () => undefined,
    dirty: false,
    searchNumbers: emptySlots('lotto6'),
    setSearchNumbers: () => undefined,
    activeType: 'lotto6',
    setActiveType: () => undefined,
    resetActive: () => undefined,
    open: false,
    setOpen: () => undefined,
    selectedDrawId: null,
    selectDraw: () => undefined,
    clearSelection: () => undefined,
    filledBalls: [],
    hasNumberFilter: false,
    searchHistory: [],
};

function sameEntry(a: SearchEntry, b: SearchEntry) {
    return a.query === b.query && a.balls.length === b.balls.length && a.balls.every((n, i) => n === b.balls[i]);
}

export function ShellSearchProvider({ children }: { children: ReactNode }) {
    const [tabs, setTabs] = useState<Record<LotteryType, ShellSearchTabState>>(() => ({
        lotto6: emptyTab('lotto6'),
        lotto7: emptyTab('lotto7'),
    }));
    const [activeType, setActiveTypeState] = useState<LotteryType>('lotto6');
    const [open, setOpen] = useState(false);
    const [selectedDrawId, setSelectedDrawId] = useState<string | null>(null);

    const clearSelection = useCallback(() => setSelectedDrawId(null), []);

    const active = tabs[activeType];
    const query = active.query;
    const searchNumbers = active.numbers;

    const setQuery = useCallback(
        (value: string) => {
            setTabs((prev) => ({
                ...prev,
                [activeType]: { ...prev[activeType], query: value },
            }));
            setSelectedDrawId(null);
        },
        [activeType],
    );

    const setSearchNumbers = useCallback(
        (next: ShellSearchNumbers) => {
            setTabs((prev) => ({
                ...prev,
                [activeType]: { ...prev[activeType], numbers: next },
            }));
            setSelectedDrawId(null);
        },
        [activeType],
    );

    const setActiveType = useCallback((type: LotteryType) => {
        setActiveTypeState(type);
        setSelectedDrawId(null);
    }, []);

    const resetActive = useCallback(() => {
        setTabs((prev) => ({ ...prev, [activeType]: emptyTab(activeType) }));
        setSelectedDrawId(null);
    }, [activeType]);

    const selectDraw = useCallback((id: string | null) => {
        setSelectedDrawId(id);
    }, []);

    const submitSearch = useCallback(() => {
        setTabs((prev) => {
            const tab = prev[activeType];
            const entry: SearchEntry = { query: tab.query.trim(), balls: collectFilled(tab.numbers) };
            const isEmpty = entry.query === '' && entry.balls.length === 0;
            // Keep earlier searches on screen (newest first, deduped); an
            // empty submit just clears the current filter.
            const history = isEmpty
                ? tab.history
                : [entry, ...tab.history.filter((e) => !sameEntry(e, entry))].slice(0, SEARCH_HISTORY_LIMIT);
            return {
                ...prev,
                [activeType]: { ...tab, applied: entry, history },
            };
        });
        setSelectedDrawId(null);
    }, [activeType]);

    const appliedQuery = active.applied.query;
    const filledBalls = active.applied.balls;
    const hasNumberFilter = filledBalls.length > 0;
    const draftBalls = collectFilled(searchNumbers);
    const dirty =
        query.trim() !== appliedQuery ||
        draftBalls.length !== filledBalls.length ||
        draftBalls.some((n, i) => n !== filledBalls[i]);

    const value = useMemo(
        () => ({
            query,
            setQuery,
            appliedQuery,
            submitSearch,
            dirty,
            searchNumbers,
            setSearchNumbers,
            activeType,
            setActiveType,
            resetActive,
            open,
            setOpen,
            selectedDrawId,
            selectDraw,
            clearSelection,
            filledBalls,
            hasNumberFilter,
            searchHistory: active.history,
        }),
        [
            query,
            setQuery,
            appliedQuery,
            submitSearch,
            dirty,
            searchNumbers,
            setSearchNumbers,
            activeType,
            setActiveType,
            resetActive,
            open,
            selectedDrawId,
            selectDraw,
            clearSelection,
            filledBalls,
            hasNumberFilter,
            active.history,
        ],
    );

    return <ShellSearchContext.Provider value={value}>{children}</ShellSearchContext.Provider>;
}

export function useShellSearch() {
    const ctx = useContext(ShellSearchContext);
    return ctx ?? fallback;
}

/** True when every filled ball appears in the draw's main numbers.
 * Bonus balls are display-only: results still show them, but matching
 * ignores them. */
export function drawContainsAllMains(
    draw: { winningNumbers: number[]; bonusNumbers: number[] },
    balls: number[],
): boolean {
    if (balls.length === 0) return true;
    const pool = new Set(draw.winningNumbers);
    return balls.every((n) => pool.has(n));
}
