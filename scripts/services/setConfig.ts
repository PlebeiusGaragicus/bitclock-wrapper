// // This is where any configuration rules related to the configuration would go. These ensure that the user can only create a valid config.

// import { compat, types as T } from "../deps.js";

import {
    matches,
    compat,
    types as T,
    YAML
} from "../deps.ts";

// deno-lint-ignore require-await
export const setConfig: T.ExpectedExports.setConfig = async (
    effects: T.Effects,
    newConfig: T.Config,
) => {
    // return compat.setConfig(effects, newConfig);

    return {
        error:
            "blah blah blah - does this error pop up?",
    };

    await effects.createDir({
        path: "start9",
        volumeId: "main",
    });

    await effects.writeFile({
        path: "start9/config.yaml",
        toWrite: YAML.stringify(newConfig),
        volumeId: "main",
    });

    const result: T.SetResult = {
        signal: "SIGTERM",
        "depends-on": {},
    };

    return { result };
};