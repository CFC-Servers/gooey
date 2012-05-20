Gooey = Gooey or {}
Gooey.Resources = {}

if Gooey.DispatchEvent then
	Gooey:DispatchEvent ("Unload")
end

function Gooey.AddResource (path)
	Gooey.Resources [path] = true
end

function Gooey.DeprecatedFunction ()
	if GLib then GLib.Error ("Gooey: Derma function should not be called.") end
end

if SERVER then
	AddCSLuaFile ("gooey/sh_init.lua")
	
	function Gooey.AddLuaFolder (folder)
		local files = file.FindInLua (folder .. "/*")
		for _, fileName in pairs (files) do
			if fileName:sub (-4) == ".lua" then
				AddCSLuaFile (folder .. "/" .. fileName)
			end
		end
	end

	function Gooey.AddLuaFolderRecursive (folder)
		Gooey.AddLuaFolder (folder)
		local folders = file.FindDir ("../lua/" .. folder .. "/*")
		for _, v in pairs (folders) do
			Gooey.AddLuaFolderRecursive (folder .. "/" .. v)
		end
	end
	
	Gooey.AddLuaFolderRecursive ("gooey")
end


include ("gooey/sh_oop.lua")
include ("gooey/sh_eventprovider.lua")
include ("gooey/sh_unicode.lua")
Gooey.EventProvider (Gooey)

if CLIENT then
	include ("gooey/ui/cl_controls.lua")
else
	include ("gooey/sh_resources.lua")
end

Gooey:DispatchEvent ("Initialize")

if SERVER then
	concommand.Add ("gooey_reload_sv", function (ply)
		if ply and not ply:IsSuperAdmin () then return end
		
		include ("autorun/sh_gooey.lua")
	end)

	concommand.Add ("gooey_reload_sh", function (ply)
		if ply and not ply:IsSuperAdmin () then return end
		
		include ("autorun/sh_gooey.lua")
		for _, ply in ipairs (player.GetAll ()) do
			ply:ConCommand ("gooey_reload")
		end
	end)
elseif CLIENT then
	concommand.Add ("gooey_reload", function ()
		include ("autorun/sh_gooey.lua")
	end)
end