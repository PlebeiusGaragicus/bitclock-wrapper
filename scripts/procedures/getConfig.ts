// To utilize the default config system built, this file is required. It defines the *structure* of the configuration file. These structured options display as changeable UI elements within the "Config" section of the service details page in the Embassy UI.

import { types as T, compat } from "../deps.js";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
    "color": {
        "type": "enum",
        "name": "Color",
        "description": "Choose a color: green or orange",
        "default": [
            "green"
        ],
        "spec": {
            values: ["green", "orange"],
            "value-names": {
                "green": "Green",
                "orange": "Orange"
            }
        }
    },
})
