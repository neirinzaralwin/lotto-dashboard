/**
 * @type {import("eslint").Linter.Config["rules"]}
 */
export const strictTypeScriptRules = {
    '@typescript-eslint/no-explicit-any': 'error',
    '@typescript-eslint/no-unused-vars': [
        'error',
        {
            argsIgnorePattern: '^_',
            varsIgnorePattern: '^_',
            caughtErrorsIgnorePattern: '^_',
            destructuredArrayIgnorePattern: '^_',
        },
    ],
    'no-restricted-syntax': [
        'error',
        {
            selector: 'TSAsExpression > TSAsExpression',
            message: 'Chained type assertions (e.g. `as unknown as`) are forbidden. Use type guards, narrowing, or validated parsing.',
        },
    ],
};

/**
 * @type {import("eslint").Linter.Config["rules"]}
 */
export const strictTypeScriptTypeCheckedRules = {
    '@typescript-eslint/no-unsafe-type-assertion': 'error',
};
