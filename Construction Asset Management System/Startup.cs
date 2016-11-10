using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Construction_Asset_Management_System.Startup))]
namespace Construction_Asset_Management_System
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
