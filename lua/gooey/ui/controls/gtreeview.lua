local PANEL = {}--[[	Events		ItemSelected (treeViewNode)		Fired when the selected tree view node changes.]]function PANEL:Init ()	self.Menu = nil		self.ChildNodeCount = 0	self.PopulationMode = "Static"	self.Populator = nil		Gooey.EventProvider (self)endfunction PANEL:AddNode (name)	local node = vgui.Create ("GTreeViewNode", self)		node:SetText (name)	node:SetParentNode (self)	node:SetRoot (self)		self:AddItem (node)	self.ChildNodeCount = self.ChildNodeCount + 1	return nodeendfunction PANEL.DefaultComparator (a, b)	return a:GetText () < b:GetText ()endfunction PANEL:FindChild (text)	for _, item in pairs (self:GetItems ()) do		if item:GetText () == text then			return item		end	end	return nilendfunction PANEL:GetChildCount ()	return self.ChildNodeCountendfunction PANEL:GetComparator ()	return self.Comparator or self.DefaultComparatorendfunction PANEL:GetMenu ()	return self.Menuendfunction PANEL:GetParentNode ()	return nilendfunction PANEL:GetPopulator ()	return self.Populatorendfunction PANEL:LayoutRecursive ()	self:InvalidateLayout ()endfunction PANEL:Remove ()	if self.Menu and self.Menu:IsValid () then self.Menu:Remove () end	_R.Panel.Remove (self)endfunction PANEL:RemoveNode (node)	if node:GetParent () ~= self:GetCanvas () then return end	self:RemoveItem (node)	self.ChildNodeCount = self.ChildNodeCount - 1	self:InvalidateLayout ()endfunction PANEL:SetMenu (menu)	self.Menu = menuendfunction PANEL:SetPopulator (populator)	self.Populator = populatorendfunction PANEL:SetSelectedItem (node)	if self.m_pSelectedItem == node then return end	DTree.SetSelectedItem (self, node)	self:DispatchEvent ("ItemSelected", node)endfunction PANEL:SortChildren (comparator)	comparator = comparator or self.Comparator or self.DefaultComparator	table.sort (self:GetItems (),		function (a, b)			if a == nil then return false end			if b == nil then return true end			return comparator (a, b)		end	)	self:InvalidateLayout ()end-- Eventsfunction PANEL:DoClick (node)	self:DispatchEvent ("Click", node)endfunction PANEL:DoRightClick (node)	if self.Menu then		self.Menu:Open (node)	end	self:DispatchEvent ("RightClick", node)endfunction PANEL:OnMouseReleased (mouseCode)	self:SetSelectedItem (nil)	if mouseCode == MOUSE_RIGHT then		self:DoRightClick ()	endendvgui.Register ("GTreeView", PANEL, "DTree") 