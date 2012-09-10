local PANEL = {}

function PANEL:Init ()
end

function PANEL:Paint ()
	local w, h = self:GetSize ()
	surface.SetDrawColor (GLib.Colors.Gray)
	surface.DrawRect (0, 0, w, h)
end

Gooey.Register ("GScrollBarCorner", PANEL, "GPanel")