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

export type ShellSearchMode = 'text' | 'numbers';

export type ShellSearchNumbers = {
    mains: number[];
    bonus: number[];
};

type ShellSearchContextValue = {
    query: string;
    setQuery: (value: string) => void;
    mode: ShellSearchMode;
    setMode: (mode: ShellSearchMode) => void;
    numberType: LotteryType;
    setNumberType: (type: LotteryType) => void;
    searchNumbers: ShellSearchNumbers;
    setSearchNumbers: (next: ShellSearchNumbers) => void;
    open: boolean;
    setOpen: (open: boolean) => void;
    selectedDrawId: string | null;
    selectDraw: (id: string | null) => void;
    clearSelection: () => void;
    filledBalls: number[];
    hasNumberFilter: boolean;
};

const ShellSearchContext = createContext<ShellSearchContextValue | null>(null);

function emptySlots(type: LotteryType): ShellSearchNumbers {
    if (type === 'lotto6') {
        return { mains: [0, 0, 0, 0, 0, 0], bonus: [0] };
    }
    return { mains: [0, 0, 0, 0, 0, 0, 0], bonus: [0, 0] };
}

function collectFilled(numbers: ShellSearchNumbers): number[] {
    return [...numbers.mains, ...numbers.bonus].filter((n) => n > 0);
}

const fallback: ShellSearchContextValue = {
    query: '',
    setQuery: () => undefined,
    mode: 'text',
    setMode: () => undefined,
    numberType: 'lotto6',
    setNumberType: () => undefined,
    searchNumbers: emptySlots('lotto6'),
    setSearchNumbers: () => undefined,
    open: false,
    setOpen: () => undefined,
    selectedDrawId: null,
    selectDraw: () => undefined,
    clearSelection: () => undefined,
    filledBalls: [],
    hasNumberFilter: false,
};

export function ShellSearchProvider({ children }: { children: ReactNode }) {
    const [query, setQueryState] = useState('');
    const [mode, setModeState] = useState<ShellSearchMode>('text');
    const [numberType, setNumberTypeState] = useState<LotteryType>('lotto6');
    const [searchNumbers, setSearchNumbersState] = useState<ShellSearchNumbers>(() =>
        emptySlots('lotto6'),
    );
    const [open, setOpen] = useState(false);
    const [selectedDrawId, setSelectedDrawId] = useState<string | null>(null);

    const clearSelection = useCallback(() => setSelectedDrawId(null), []);

    const setQuery = useCallback(
        (value: string) => {
            setQueryState(value);
            setSelectedDrawId(null);
        },
        [],
    );

    const setMode = useCallback((next: ShellSearchMode) => {
        setModeState(next);
        setSelectedDrawId(null);
    }, []);

    const setNumberType = useCallback((type: LotteryType) => {
        setNumberTypeState(type);
        setSearchNumbersState(emptySlots(type));
        setSelectedDrawId(null);
    }, []);

    const setSearchNumbers = useCallback((next: ShellSearchNumbers) => {
        setSearchNumbersState(next);
        setSelectedDrawId(null);
    }, []);

    const selectDraw = useCallback((id: string | null) => {
        setSelectedDrawId(id);
    }, []);

    const filledBalls = useMemo(() => collectFilled(searchNumbers), [searchNumbers]);
    const hasNumberFilter = mode === 'numbers' && filledBalls.length > 0;

    const value = useMemo(
        () => ({
            query,
            setQuery,
            mode,
            setMode,
            numberType,
            setNumberType,
            searchNumbers,
            setSearchNumbers,
            open,
            setOpen,
            selectedDrawId,
            selectDraw,
            clearSelection,
            filledBalls,
            hasNumberFilter,
        }),
        [
            query,
            setQuery,
            mode,
            setMode,
            numberType,
            setNumberType,
            searchNumbers,
            setSearchNumbers,
            open,
            selectedDrawId,
            selectDraw,
            clearSelection,
            filledBalls,
            hasNumberFilter,
        ],
    );

    return <ShellSearchContext.Provider value={value}>{children}</ShellSearchContext.Provider>;
}

export function useShellSearch() {
    const ctx = useContext(ShellSearchContext);
    return ctx ?? fallback;
}

/** True when every filled ball appears in the draw's mains ∪ bonus. */
export function drawContainsAllBalls(
    draw: { winningNumbers: number[]; bonusNumbers: number[] },
    balls: number[],
): boolean {
    if (balls.length === 0) return true;
    const pool = new Set([...draw.winningNumbers, ...draw.bonusNumbers]);
    return balls.every((n) => pool.has(n));
}
