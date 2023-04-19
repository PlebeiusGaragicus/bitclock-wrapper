// To utilize the default config system built, this file is required. It defines the *structure* of the configuration file. These structured options display as changeable UI elements within the "Config" section of the service details page in the Embassy UI.

// import { types as T, compat } from "../deps.js";

// export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
//     "default-locale": {
//         "name": "Default Locale",
//         "description": 'This sets the default locale on your Nextcloud server.  It overrides automatic locale detection on public pages like login or shared items. User\'s locale preferences configured under “personal -> locale” override this setting after they have logged in.',
//         "type": "enum",
//         "values": ["en_US", "en_GB", "zh", "es", "es_419", "hi", "pt", "ru", "ja", "de", "fr", "pl"],
//         "value-names": {
//             "en_US": "English (US)",
//             "en_GB": "English (GB)",
//             "zh": "Chinese",
//             "es": "Spanish",
//             "es_419": "Spanish (LA)",
//             "hi": "Hindi",
//             "pt": "Portuguese",
//             "ru": "Russian",
//             "ja": "Japanese",
//             "de": "German",
//             "fr": "French",
//             "pl": "Polish",
//         },
//         "default": "en_US",
//     },
// })


import { compat, types as T } from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
    "mediasources": {
        "type": "list",
        "subtype": "enum",
        "name": "Media Sources",
        "description": "List of Media Sources to use with Jellyfin",
        "range": "[1,*)",
        "default": [
            "nextcloud"
        ],
        "spec": {
            values: ["nextcloud", "filebrowser"],
            "value-names": {
                "nextcloud": "NextCloud",
                "filebrowser": "File Browser"
            }
        }
    },
    "chromecast": {
        "name": "Chromecast",
        "description": "Chromecast plugin to allow casting to other devices.",
        "type": "boolean",
        "default": false,
    },
    "trailers": {
        "name": "Youtube trailers",
        "description": "Auto-load movie trailers from YouTube.",
        "type": "boolean",
        "default": false,
    },
} as T.ConfigSpec);