Config = Config or {}

local filePath = "locales/" .. Config.Locale .. ".json"
local jsonData = LoadResourceFile(GetCurrentResourceName(), filePath)

if not jsonData then
    translations = {}
else
    translations = json.decode(jsonData)

    if not translations then
        print("^1[ERROR] Failed to decode JSON in: " .. filePath .. "^0")
        translations = {}
    end
end

function _Locale(key)
    return translations[key] or key
end
