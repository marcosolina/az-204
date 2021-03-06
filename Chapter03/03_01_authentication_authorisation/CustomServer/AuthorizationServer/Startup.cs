﻿using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(AuthorizationServer.Startup))]
namespace AuthorizationServer
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            ConfigureWebApi(app);
        }
    }
}
