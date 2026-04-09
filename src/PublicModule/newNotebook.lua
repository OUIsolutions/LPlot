

PublicModuleObject.newNotebook = function ()
    ---@type PROJECT_NAMENotebook
    local selfobj = {}
    selfobj.content = {}
    selfobj.add_text = function (text) return PrivateModuleObject.Notebook___add_text(selfobj, text) end
    selfobj.add_title = function (title) return PrivateModuleObject.Notebook___add_title(selfobj, title) end
    selfobj.add_table = function (data) return PrivateModuleObject.Notebook___add_table(selfobj, data) end
    selfobj.add_bar_chart     = function (data, options) return PrivateModuleObject.Notebook___add_bar_chart(selfobj, data, options) end
    selfobj.add_line_chart    = function (data, options) return PrivateModuleObject.Notebook___add_line_chart(selfobj, data, options) end
    selfobj.add_area_chart    = function (data, options) return PrivateModuleObject.Notebook_add_area_chart(selfobj, data, options) end
    selfobj.add_pie_chart     = function (data, options) return PrivateModuleObject.Notebook___add_pie_chart(selfobj, data, options) end
    selfobj.add_scatter_chart = function (data, options) return PrivateModuleObject.Notebook___add_scatter_chart(selfobj, data, options) end
    selfobj.add_subtitle      = function (subtitle)      return PrivateModuleObject.Notebook___add_subtitle(selfobj, subtitle) end
    selfobj.add_separator     = function ()              return PrivateModuleObject.Notebook___add_separator(selfobj) end
    selfobj.get_html = function (style) return PrivateModuleObject.Notebook___get_html(selfobj, style) end
    return selfobj
end