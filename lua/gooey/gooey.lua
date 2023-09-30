if Gooey then return end
Gooey = Gooey or {}

local t = GLib.LoadTimer ("Gooey")

GLib.Initialize ("Gooey", Gooey)
GLib.AddCSLuaPackSystem ("Gooey")
GLib.AddCSLuaPackFile ("autorun/gooey.lua")
GLib.AddCSLuaPackFolderRecursive ("gooey")
t.step ("Init")

function Gooey.DeprecatedFunction ()
	GLib.Error ("Gooey: Derma function should not be called.")
end

function Gooey.DeprecatedFunctionFactory (alternativeFunctionName)
	return function ()
		GLib.Error ("Gooey: Derma function should not be called. Use " .. alternativeFunctionName .. " instead.")
	end
end

if CLIENT then
	function Gooey.Register (className, classTable, baseClassName)
		local rawget = rawget
		local GetControlTable = vgui.GetControlTable

		GLib.CallDelayed (
			function ()
				local init = classTable.Init

				local basePanelInjected = false

				-- Check if GBasePanel methods have already been added to a base class
				local baseClass = GetControlTable (baseClassName)
				while baseClass do
					if baseClass._ctor then
						basePanelInjected = true
						break
					end
					baseClass = GetControlTable (baseClass.Base)
				end

				if not basePanelInjected then
					-- Merge in GBasePanel methods
					for k, v in pairs (Gooey.BasePanel) do
						if not rawget (classTable, k) then
							classTable [k] = v
						end
					end

					classTable.Init = function (...)
						-- BasePanel._ctor will check for and avoid multiple initialization
						Gooey.BasePanel._ctor (...)
						if init then
							init (...)
						end
					end
				end

				vgui.Register (className, classTable, baseClassName)
			end
		)
	end

	t.step ("Step 1")

	include ("clipboard.lua")
	include ("rendercontext.lua")
	t.step ("Step 2")

	include ("interpolators/timeinterpolator.lua")
	include ("interpolators/normalizedtimeinterpolator.lua")
	include ("interpolators/linearinterpolator.lua")
	include ("interpolators/accelerationdecelerationinterpolator.lua")
	include ("interpolators/scaledtimeinterpolator.lua")
	include ("interpolators/liveadditiveinterpolator.lua")
	include ("interpolators/livelinearinterpolator.lua")
	include ("interpolators/livesmoothinginterpolator.lua")
	t.step ("Step 3")

	if GetConVar("is_gcompute_user"):GetBool() then
		include ("ui/controls.lua")
		t.step ("Step 3")
	end
end

Gooey.CodeExporter = GLib.Lua.CodeExporter ("Gooey", "gooey")
Gooey.CodeExporter:AddAuxiliarySystemName ("GLib")

Gooey:DispatchEvent ("Initialize")

Gooey.AddReloadCommand ("gooey/gooey.lua", "gooey", "Gooey")

t.step ("Step 4")
