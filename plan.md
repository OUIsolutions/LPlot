create the notebook.add_bar_chart function , it should work in the followwwzzzing format
```lua
local bar_code =  {
    payd_users=55,
    free_users=100,
    
}
local options = {
    display="vertical",
    colors={
        payd_users="#e74c3c",
        free_users="#2ecc71",
        trial_users="#f39c12"
    },
    size={
        width=800,
        height=600
    },
    title="Bar Chart",
    subtitle="Bar Chart Subtitle",
    
}
notebook.add_bar_chart(bar_code,options)
```