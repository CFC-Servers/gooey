local PANEL = {}

function PANEL:Init ()
	self.TextRenderer = nil
	self.Text = nil
	
	self:AddEventListener ("FontChanged",
		function (_, font)
			if not self.TextRenderer then return end
			self.TextRenderer:SetFont (font)
		end
	)
	
	self:AddEventListener ("SizeChanged",
		function (_, width, height)
			if not self.TextRenderer then return end
			self.TextRenderer:SetWordWrapWidth (width)
		end
	)
	
	self:SetTextRenderer (Gooey.SilkiconTextRenderer ())
end

function PANEL:GetRenderer ()
	return self.TextRenderer
end

function PANEL:GetText ()
	return self.Text
end

function PANEL:GetWordWrap ()
	return self.WordWrap
end

function PANEL:Paint (w, h)
	if not self.TextRenderer then return end
	self.TextRenderer:Render (Gooey.RenderContext)
	return true
end

function PANEL:SetTextRenderer (textRenderer)
	self.TextRenderer = textRenderer
	if self.TextRenderer then
		self.TextRenderer:SetFont (self:GetFont ())
		self.TextRenderer:SetText (self:GetText ())
		self.TextRenderer:SetWordWrap (self:GetWordWrap ())
		self.TextRenderer:SetWordWrapWidth (self:GetWide ())
	end
end

function PANEL:SetText (text)
	if self.Text == text then return end
	
	self.Text = text
	debug.getregistry ().Panel.SetText (self, text)
	
	if not self.TextRenderer then return end
	self.TextRenderer:SetText (self.Text)
end

function PANEL:SetWordWrap (wordWrap)
	if self.WordWrap == wordWrap then return end
	
	self.WordWrap = wordWrap
	debug.getregistry ().Panel.SetWrap (self, wordWrap)
	
	if not self.TextRenderer then return end
	self.TextRenderer:SetWordWrap (self.WordWrap)
end
PANEL.SetWrap = PANEL.SetWordWrap

function PANEL:SizeToContents ()
	if not self.TextRenderer then return end
	self:SetSize (self.TextRenderer:GetWidth (), self.TextRenderer:GetHeight ())
end

-- Event handlers
function PANEL:OnRemoved ()
	if self.TextRenderer then
		self.TextRenderer:dtor ()
	end
end

Gooey.Register ("GLabelX", PANEL, "GLabel")