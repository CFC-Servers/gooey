local PANEL = {}

--[[
	Events:
		SelectedChanged (item)
			Fired when the selected item has changed.
		SelectedCleared ()
			Fired when the selection has been cleared.
]]

function PANEL:Init ()
	Gooey.EventProvider (self)
	self.SelectionController = Gooey.SelectionController (self)
	
	self.Disabled = false
	self.LastClickTime = 0

	self.Menu = nil
	self.ShowIcons = true
	
	self:SetItemHeight (20)
	
	self.SelectionController:AddEventListener ("SelectionChanged",
		function (_, item)
			self:DispatchEvent ("SelectionChanged", item)
		end
	)
	
	self.SelectionController:AddEventListener ("SelectionCleared",
		function (_, item)
			self:DispatchEvent ("SelectionCleared", item)
		end
	)
end

function PANEL:AddColumn (name, material, position)
	local column = nil
	if self.m_bSortable then
		column = vgui.Create ("GListViewColumn", self)
	else
		column = vgui.Create ("DListView_ColumnPlain", self)
	end
	column:SetName (name)
	column:SetMaterial (material)
	column:SetZPos (10)
	
	if iPosition then
	else
		local ID = table.insert (self.Columns, column)
		column:SetColumnID(ID)
	end
	
	self:InvalidateLayout ()
	
	return column
end

function PANEL:AddLine (...)
	self:SetDirty (true)
	self:InvalidateLayout ()

	local line = vgui.Create ("GListViewItem", self.pnlCanvas)
	self.Lines [#self.Lines + 1] = line
	local id = #self.Lines

	line:SetListView (self)
	line:SetID (id)
	line:SetTall (self.ItemHeight)
	if self.Disabled then
		line:SetDisabled (self.Disabled)
	end

	local values = {...}
	for k, column in pairs (self.Columns) do
		if column:GetType () == "Text" then
			line:SetColumnText (k, values [k] or "")
		elseif column:GetType () == "Checkbox" then
			line:SetCheckState (k, values [k] or false)
		end
	end
	
	self.Sorted [#self.Sorted + 1] = line
	local sortID = #self.Sorted
	if sortID % 2 == 1 then
		line:SetAltLine (true)
	end

	return line
end

function PANEL:ClearSelection ()
	self.SelectionController:ClearSelection ()
end

function PANEL.DefaultComparator (a, b)
	return a:GetText () < b:GetText ()
end

function PANEL:FindLine (text)
	for _, line in pairs (self.Lines) do
		if line:GetColumnText (1) == text then
			return line
		end
	end
	return nil
end

function PANEL:GetColumnHeight ()
	local column = self.Columns [1]
	if not column then return 0 end
	return column:GetTall ()
end

function PANEL:GetColumns ()
	return self.Columns
end

function PANEL:GetContentBounds ()
	local scrollbarWidth = 0
	if self.VBar and self.VBar:IsVisible () then
		scrollbarWidth = self.VBar:GetWide ()
	end
	return 0, self:GetColumnHeight (), self:GetWide () - scrollbarWidth, self:GetTall ()
end

function PANEL:GetItemEnumerator ()
	local next, tbl, key = pairs (self:GetItems ())
	return function ()
		key = next (tbl, key)
		return tbl [key]
	end
end

function PANEL:GetItemHeight ()
	return self:GetDataHeight ()
end

function PANEL:GetItems ()
	return self.Lines
end

function PANEL:GetSelectedItems ()
	return self.SelectionController:GetSelectedItems ()
end

function PANEL:GetSelectedItem ()
	return self.SelectionController:GetSelectedItem ()
end

function PANEL:GetSelectionEnumerator ()
	return self.SelectionController:GetSelectionEnumerator ()
end

function PANEL:GetSelectionMode ()
	return self.SelectionController:GetSelectionMode ()
end

function PANEL:IsDisabled ()
	return self.Disabled
end

function PANEL:ItemFromPoint (x, y)
	x, y = self:LocalToScreen (x, y)
	for _, item in pairs (self:GetItems ()) do
		local px, py = item:LocalToScreen (0, 0)
		local w, h = item:GetSize ()
		if px <= x and x < px + w and
			py <= y and y < py + h then
			return item
		end
	end
	return nil
end

function PANEL:SetDisabled (disabled)
	if disabled == nil then
		disabled = true
	end
	self.Disabled = disabled
	for _, Line in pairs (self.Lines) do
		Line:SetDisabled (disabled)
	end
end

function PANEL:PaintOver ()
	self.SelectionController:PaintOver (self)
end

function PANEL:Remove ()
	if self.Menu and
		self.Menu:IsValid () then
		self.Menu:Remove ()
	end
	_R.Panel.Remove (self)
end

function PANEL:SetItemHeight (itemHeight)
	self:SetDataHeight (itemHeight)
end

function PANEL:Sort (comparator)
	comparator = comparator or self.Comparator or self.DefaultComparator
	table.sort (self.Sorted,
		function (a, b)
			if a == nil then return false end
			if b == nil then return true end
			return comparator (a, b)
		end
	)
	
	self:SetDirty (true)
	self:InvalidateLayout ()
end

function PANEL:SortByColumn (columnId, descending)
	table.Copy (self.Sorted, self.Lines)
	table.sort (self.Sorted,
		function (a, b)
			if descending then
				a, b = b, a
			end

			return (a:GetColumnText (columnId) or "") < (b:GetColumnText (columnId) or "")
		end
	)
	
	self:SetDirty (true)
	self:InvalidateLayout ()
end

function PANEL:SetSelectionMode (selectionMode)
	self.SelectionController:SetSelectionMode (selectionMode)
end

-- Events
function PANEL:DoClick ()
	if SysTime () - self.LastClickTime < 0.2 then
		self:DoDoubleClick ()
		self.LastClickTime = 0
	else
		self:DispatchEvent ("Click", self:ItemFromPoint (self:CursorPos ()))
		self.LastClickTime = SysTime ()
	end
end

function PANEL:DoDoubleClick ()
	self:DispatchEvent ("DoubleClick", self:ItemFromPoint (self:CursorPos ()))
end

function PANEL:DoRightClick ()
	self:DispatchEvent ("RightClick", self:ItemFromPoint (self:CursorPos ()))
end

function PANEL:ItemChecked (line, i, checked)
	self:DispatchEvent ("ItemChecked", line, i, checked)
end

function PANEL:OnCursorMoved (x, y)
	self:DispatchEvent ("MouseMove", 0, x, y)
end

function PANEL:OnMousePressed (mouseCode)
	self:DispatchEvent ("MouseDown", mouseCode, self:CursorPos ())
end

function PANEL:OnMouseReleased (mouseCode)
	self:DispatchEvent ("MouseUp", mouseCode, self:CursorPos ())
	if mouseCode == MOUSE_LEFT then
		self:DoClick ()
	elseif mouseCode == MOUSE_RIGHT then
		self:DoRightClick ()
		if self:GetSelectionMode () == Gooey.SelectionMode.Multiple then
			if self.Menu then self.Menu:Open (self:GetSelectedItems ()) end
		else
			if self.Menu then self.Menu:Open (self:GetSelectedItem ()) end
		end
	end
end

vgui.Register ("GListView", PANEL, "DListView")