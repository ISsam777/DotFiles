return {
   'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
     
              local alpha = require'alpha'
         local dashboard = require'alpha.themes.dashboard'
	 dashboard.section.header.val={
        [[                                                                   ]],
	[[ ███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   ]],
	[[ ███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ]],
	[[ ███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
	[[ ███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
	[[ ███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
	[[ ███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███ ]],
	[[ ███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███ ]],
	[[  ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀  ]],
	[[                                                                   ]],             
         }	
end
};
