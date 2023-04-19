// // // // This is where any configuration rules related to the configuration would go. These ensure that the user can only create a valid config.

// // export const setConfig = compat.setConfig;


// import { compat, types as T } from "../deps.ts";

// // deno-lint-ignore require-await
// export const setConfig: T.ExpectedExports.setConfig = async () => {
//     return compat.setConfig(effects, );
// };


import { compat, types as T } from "../deps.ts";

// deno-lint-ignore require-await
export const setConfig: T.ExpectedExports.setConfig = async (
    effects: T.Effects,
    newConfig: T.Config,
) => {
    return compat.setConfig(effects, newConfig, {});
};
