-- File: lua/plugins/configs/cmp_csharp.lua
local M = {}

---@param entry table
---@param other_entry table
---@return boolean|nil
function M.sort_csharp(entry, other_entry)
	-- Check if the current file is C#
	if vim.bo.filetype ~= "cs" then
		return nil
	end

	-- Define the desired order for C# kind types
	local kind_order = {
		Method = 1,
		Function = 1,
		Property = 2,
		Field = 3,
		Variable = 3,
	}

	-- A list of common Unity methods we want to prioritize lower
	local unity_inherited_methods = {
		"Awake",
		"Start",
		"Update",
		"FixedUpdate",
		"LateUpdate",
		"OnEnable",
		"OnDisable",
		"OnTriggerEnter",
		"OnTriggerStay",
		"OnTriggerExit",
		"OnCollisionEnter",
		"OnCollisionStay",
		"OnCollisionExit",
		"GetComponent",
		"GetComponents",
		"GetComponentInParent",
		"GetComponentsInParent",
		"GetComponentInChildren",
		"GetComponentsInChildren",
		"Invoke",
		"InvokeRepeating",
		"CancelInvoke",
		"BroadcastMessage",
		"CompareTag",
		"Equals",
		"GetHashCode",
		"ToString",
		"GetComponentIndex",
		"GetInstanceID",
		"GetType",
		"IsInvoking",
		"MemberwiseClone",
		"SendMessage",
		"SendMessageUpwards",
		"StartCoroutine",
		"StartCoroutine_Auto",
		"StopAllCoroutines",
		"StopCoroutine",
		"TryGetComponent",
		"Find",
		"FindObjectOfType",
		"FindObjectsOfType",
	}

	-- A list of common Unity properties we want to prioritize lower
	local unity_inherited_properties = {
		"destroyCancellationToken",
		"didAwake",
		"didStart",
		"enabled",
		"gameObject",
		"hideFlags",
		"isActiveAndEnabled",
		"name",
		"runInEditMode",
		"tag",
		"transform",
		"useGUILayout",
	}

	-- Check if an item is a common inherited Unity method
	local function is_unity_inherited_method(entry)
		if entry.completion_item.kind == vim.lsp.protocol.CompletionItemKind.Method then
			local label = entry.completion_item.label
			for _, method_name in ipairs(unity_inherited_methods) do
				if label:lower() == method_name:lower() or label:find(method_name .. "%s*%(.*%)") then
					return true
				end
			end
		end
		return false
	end

	-- Check if an item is a common inherited Unity property
	local function is_unity_inherited_property(entry)
		if entry.completion_item.kind == vim.lsp.protocol.CompletionItemKind.Property then
			local label = entry.completion_item.label
			for _, prop_name in ipairs(unity_inherited_properties) do
				if label:lower() == prop_name:lower() then
					return true
				end
			end
		end
		return false
	end

	-- 1. Sort by Unity inherited methods (push them to the bottom of the method list)
	local is_entry_unity_method = is_unity_inherited_method(entry)
	local is_other_entry_unity_method = is_unity_inherited_method(other_entry)

	if is_entry_unity_method and not is_other_entry_unity_method then
		return false -- Place Unity method lower
	elseif not is_entry_unity_method and is_other_entry_unity_method then
		return true -- Keep non-Unity method higher
	end

	-- 2. Sort by Unity inherited properties (push them to the bottom of the property list)
	local is_entry_unity_property = is_unity_inherited_property(entry)
	local is_other_entry_unity_property = is_unity_inherited_property(other_entry)

	if is_entry_unity_property and not is_other_entry_unity_property then
		return false -- Place Unity property lower
	elseif not is_entry_unity_property and is_other_entry_unity_property then
		return true -- Keep non-Unity property higher
	end

	-- 3. Sort by Unity base classes (push them to the bottom of the class list)
	local unity_base_classes = { "MonoBehaviour", "ScriptableObject", "Editor" }

	local function is_unity_base_class(entry)
		if entry.completion_item.kind == vim.lsp.protocol.CompletionItemKind.Class then
			local label = entry.completion_item.label
			for _, base_class in ipairs(unity_base_classes) do
				if label == base_class then
					return true
				end
			end
		end
		return false
	end

	local is_entry_unity_base = is_unity_base_class(entry)
	local is_other_entry_unity_base = is_unity_base_class(other_entry)

	if is_entry_unity_base and not is_other_entry_unity_base then
		return false
	elseif not is_entry_unity_base and is_other_entry_unity_base then
		return true
	end

	-- 4. Sort by C# derived classes
	local function is_derived_class(entry)
		if entry.completion_item.kind == vim.lsp.protocol.CompletionItemKind.Class then
			local detail = entry.completion_item.detail or ""
			if detail:find(":%s*") and not is_unity_base_class(entry) then
				return true
			end
		end
		return false
	end

	local is_entry_derived = is_derived_class(entry)
	local is_other_entry_derived = is_derived_class(other_entry)

	if is_entry_derived and not is_other_entry_derived then
		return false
	elseif not is_entry_derived and is_other_entry_derived then
		return true
	end

	-- 5. Sort by kind: methods > properties > variables (this is the general rule)
	local entry_kind = vim.lsp.protocol.CompletionItemKind[entry.completion_item.kind]
	local other_entry_kind = vim.lsp.protocol.CompletionItemKind[other_entry.completion_item.kind]

	local entry_order = kind_order[entry_kind] or 4
	local other_entry_order = kind_order[other_entry_kind] or 4

	if entry_order ~= other_entry_order then
		return entry_order < other_entry_order
	end

	return nil
end

return M
