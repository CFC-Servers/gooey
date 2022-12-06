Gooey.UI = {}

local pieces = {
	function()
		-- Fonts
		include ("gooey/ui/fonts.lua")

		-- Layout
		include ("gooey/ui/layout/orientation.lua")
		include ("gooey/ui/layout/horizontalalignment.lua")
		include ("gooey/ui/layout/verticalalignment.lua")
		include ("gooey/ui/layout/sizingmethod.lua")

		include ("gooey/ui/sortorder.lua")
		include ("gooey/ui/splitcontainerpanel.lua")

		-- Images
		include ("gooey/ui/imagecacheentry.lua")
		include ("gooey/ui/imagecache.lua")

		include ("gooey/ui/render.lua")
		include ("gooey/ui/rendertype.lua")
	end,

	function()

		-- Actions
		include ("gooey/ui/action.lua")
		include ("gooey/ui/actionmap.lua")
		include ("gooey/ui/toggleaction.lua")

		include ("gooey/ui/booleancontroller.lua")
		include ("gooey/ui/visibilitycontroller.lua")

		-- Mouse
		include ("gooey/ui/mouse/mousemonitor.lua")

		-- Event Bases
		include ("gooey/ui/mouse/mouseevents.lua")

		-- Keyboard
		include ("gooey/ui/keyboard/keyboardmap.lua")
		include ("gooey/ui/keyboard/keyboardmonitor.lua")
		include ("gooey/ui/keyboard/escapekeyhandler.lua")

		-- Bindings
		include ("gooey/ui/keyboard/keybinds.lua")

		-- Controllers
		include ("gooey/ui/dragcontroller.lua")
		include ("gooey/ui/dragdropcontroller.lua")
		include ("gooey/ui/selectioncontroller.lua")

		include ("gooey/ui/iclipboardtarget.lua")

		-- Effects
		include ("gooey/ui/alphacontroller.lua")
		include ("gooey/ui/tickprovider.lua")
	end,

	function()
		-- Custom Text Renderers
		include ("gooey/ui/textrenderer.lua")
		include ("gooey/ui/silkicontextrenderer.lua")

		-- Buttons
		include ("gooey/ui/buttoncontroller.lua")
		include ("gooey/ui/clipboardcontroller.lua")
		include ("gooey/ui/savecontroller.lua")

		-- History
		include ("gooey/ui/history/ihistorystack.lua")

		include ("gooey/ui/history/historyitem.lua")
		include ("gooey/ui/history/historystack.lua")
		include ("gooey/ui/history/historycontroller.lua")

		include ("gooey/ui/history/undoredoitem.lua")
		include ("gooey/ui/history/undoredostack.lua")
		include ("gooey/ui/history/undoredocontroller.lua")

		include ("gooey/ui/vpanelcontainer.lua")

		-- Control Bases
		include ("gooey/ui/controls/gbasepanel.lua")
	end,

	function()
		-- ListBox
		Gooey.ListBox = {}
		include ("gooey/ui/controls/listbox/glistbox.lua")
		include ("gooey/ui/controls/listbox/glistboxitem.lua")
		include ("gooey/ui/controls/listbox/itemcollection.lua")
		include ("gooey/ui/controls/listbox/listboxitem.lua")
		include ("gooey/ui/controls/listbox/keyboardmap.lua")
	end,

	function()
		-- ListView
		Gooey.ListView = {}
		include ("gooey/ui/controls/listview/glistview.lua")
		include ("gooey/ui/controls/listview/glistviewcolumnheader.lua")
		include ("gooey/ui/controls/listview/glistviewcolumnsizegrip.lua")
		include ("gooey/ui/controls/listview/glistviewheader.lua")
		include ("gooey/ui/controls/listview/glistviewitem.lua")
		include ("gooey/ui/controls/listview/column.lua")
		include ("gooey/ui/controls/listview/columncollection.lua")
		include ("gooey/ui/controls/listview/columntype.lua")
		include ("gooey/ui/controls/listview/itemcollection.lua")
		include ("gooey/ui/controls/listview/keyboardmap.lua")
	end,

	function()
		-- Menu
		include ("gooey/ui/controls/menu/menu.lua")
		include ("gooey/ui/controls/menu/basemenuitem.lua")
		include ("gooey/ui/controls/menu/menuitem.lua")
		include ("gooey/ui/controls/menu/menuseparator.lua")
		include ("gooey/ui/controls/menu/visibilitycontrol.lua")
		include ("gooey/ui/controls/menu/gmenu.lua")
		include ("gooey/ui/controls/menu/gmenuitem.lua")
		include ("gooey/ui/controls/menu/gmenuseparator.lua")

		-- Scrolling
		include ("gooey/ui/scrollableviewcontroller.lua")
		include ("gooey/ui/controls/gbasescrollbar.lua")
		include ("gooey/ui/controls/ghscrollbar.lua")
		include ("gooey/ui/controls/gvscrollbar.lua")

		-- Tooltips
		include ("gooey/ui/controls/tooltips/tooltippositioningmode.lua")
		include ("gooey/ui/controls/tooltips/tooltipcontroller.lua")
		include ("gooey/ui/controls/tooltips/tooltipmanager.lua")
		include ("gooey/ui/controls/tooltips/gtooltip.lua")
	end,

	function()
		-- Controls
		include ("gooey/ui/controls/gbutton.lua")
		include ("gooey/ui/controls/gcheckbox.lua")
		include ("gooey/ui/controls/gcombobox.lua")
		include ("gooey/ui/controls/gcomboboxitem.lua")
		include ("gooey/ui/controls/gcomboboxx.lua")
		include ("gooey/ui/controls/gcontainer.lua")
		include ("gooey/ui/controls/geditablelabel.lua")
		include ("gooey/ui/controls/gframe.lua")
		include ("gooey/ui/controls/ggraph.lua")
		include ("gooey/ui/controls/ggroupbox.lua")
		include ("gooey/ui/controls/ghtml.lua")
		include ("gooey/ui/controls/glabel.lua")
		include ("gooey/ui/controls/glabelx.lua")
		include ("gooey/ui/controls/gmenustrip.lua")
		include ("gooey/ui/controls/gmenustripitem.lua")
		include ("gooey/ui/controls/gmodelchoice.lua")
		include ("gooey/ui/controls/gpanel.lua")
		include ("gooey/ui/controls/gpanellist.lua")
		include ("gooey/ui/controls/gprogressbar.lua")
		include ("gooey/ui/controls/gresizegrip.lua")
		include ("gooey/ui/controls/gscrollbarbutton.lua")
		include ("gooey/ui/controls/gscrollbarcorner.lua")
		include ("gooey/ui/controls/gscrollbargrip.lua")
		include ("gooey/ui/controls/gsplitcontainer.lua")
		include ("gooey/ui/controls/gsplitcontainersplitter.lua")
		include ("gooey/ui/controls/gstatusbar.lua")
		include ("gooey/ui/controls/gstatusbarcombobox.lua")
		include ("gooey/ui/controls/gstatusbarpanel.lua")
		include ("gooey/ui/controls/gstatusbarcomboboxpanel.lua")
		include ("gooey/ui/controls/gtabcontrol.lua")
		include ("gooey/ui/controls/gtextentry.lua")
		include ("gooey/ui/controls/gtoolbar.lua")
		include ("gooey/ui/controls/gtreeviewnode.lua")
		include ("gooey/ui/controls/gtreeview.lua")
		include ("gooey/ui/controls/gurllabel.lua")
		include ("gooey/ui/controls/gworldview.lua")
		include ("gooey/ui/controls/gverticallayout.lua")

		include ("gooey/ui/controls/gvpanel.lua")
		include ("gooey/ui/controls/gclosebutton.lua")
		include ("gooey/ui/controls/gimage.lua")
		include ("gooey/ui/controls/gtab.lua")
		include ("gooey/ui/controls/gtabheader.lua")
		include ("gooey/ui/controls/gtoolbaritem.lua")
		include ("gooey/ui/controls/gtoolbarbutton.lua")
		include ("gooey/ui/controls/gtoolbarcombobox.lua")
		include ("gooey/ui/controls/gtoolbarseparator.lua")
		include ("gooey/ui/controls/gtoolbarsplitbutton.lua")
	end,

	function()
		-- Dialogs
		include ("gooey/ui/dialogs/dialogkeyboardmap.lua")
		include ("gooey/ui/dialogs/simplebuttondialog.lua")

		-- Glyphs
		include ("gooey/ui/glyphs.lua")
		include ("gooey/ui/glyphs/close.lua")
		include ("gooey/ui/glyphs/down.lua")
		include ("gooey/ui/glyphs/up.lua")
	end,
}

for _, piece in ipairs (pieces) do
	GLib.CallDelayed (piece, 0.025)
end
