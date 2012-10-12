local PANEL = {}
PANEL.GetSelected	= Gooey.DeprecatedFunction
PANEL.SetSelected	= Gooey.DeprecatedFunction

function PANEL:Init ()
	self.ListBox = nil
	self.ID = nil
	
	-- Layout
	self.Indent = 0
	self.Icon = nil
	
	-- Selection
	self.Selectable = true
end

function PANEL:CanSelect ()
	return self.Selectable
end

function PANEL:GetIcon ()
	return self.Icon and self.Icon.ImageName or nil
end

function PANEL:GetID ()
	return self.ID
end

function PANEL:GetIndent ()
	return self.Indent
end

PANEL.GetText = _R.Panel.GetValue

function PANEL:IsSelected ()
	return self.ListBox.SelectionController:IsSelected (self)
end

--[[
	Taken from skins/default.lua
]]
function PANEL:Paint ()
	if self:IsSelected () then
		local col = self:GetSkin ().combobox_selected
		surface.SetDrawColor (col.r, col.g, col.b, col.a)
		self:DrawFilledRect ()
	elseif self.Hovered then
		local col = self:GetSkin ().combobox_selected
		surface.SetDrawColor (col.r, col.g, col.b, col.a * 0.25)
		self:DrawFilledRect ()
	end
end

function PANEL:Select ()
	self.ListBox.SelectionController:ClearSelection ()
	self.ListBox.SelectionController:AddToSelection (self)
end

function PANEL:SetCanSelect (canSelect)
	self.Selectable = canSelect
end

function PANEL:SetListBox (listBox)
	self.ListBox = listBox
	self:SetMother (listBox)
end

function PANEL:SetIcon (icon)
	if not icon then
		self.Icon:Remove ()
		self.Icon = nil
		self:SetTextInset (self.Indent + 5)
		return
	end
	if not self.Icon then
		self.Icon = vgui.Create ("GImage", self)
		self.Icon:SetPos (self.Indent + 4, 2)
		self.Icon:SetSize (16, 16)
	end
	self:SetTextInset (self.Indent + 24)
	
	self.Icon:SetImage (icon)
end

function PANEL:SetIndent (indent)
	self.Indent = indent
	if self.Icon then
		self.Icon:SetPos (self.Indent + 4, 2)
		self:SetTextInset (self.Indent + 24)
	else
		self:SetTextInset (self.Indent + 5)
	end
end

function PANEL:SetID (id)
	if self.ID == id then
		return
	end
	if self.ListBox then
		self.ListBox:SetItemID (self, id)
	end
	self.ID = id
end

-- Event handlers
function PANEL:DoClick ()
	self.ListBox:DoClick (self)
end

function PANEL:DoRightClick ()
	self.ListBox:DoRightClick (self)
end

function PANEL:OnMousePressed (mouseCode)
	self.ListBox:OnMousePressed (mouseCode)
end

function PANEL:OnMouseReleased (mouseCode)
	self.ListBox:OnMouseReleased (mouseCode)
	if mouseCode == MOUSE_LEFT then
		self:DoClick ()
	elseif mouseCode == MOUSE_RIGHT then
		self:DoRightClick ()
	end
end

Gooey.Register ("GListBoxItem", PANEL, "DComboBoxItem")