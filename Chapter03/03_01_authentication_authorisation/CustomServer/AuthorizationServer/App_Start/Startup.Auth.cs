using System;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.Google;
using Microsoft.Owin.Security.OAuth;
using Microsoft.Owin.Security.Infrastructure;
using AuthorizationServer.Constants;
using System.Threading.Tasks;
using System.Collections.Concurrent;
using System.Security.Claims;
using System.Security.Principal;
using System.Linq;
using Owin;
using AuthorizationServer.Models;

namespace AuthorizationServer
{
    public partial class Startup
    {
        // For more information on configuring authentication, please visit https://go.microsoft.com/fwlink/?LinkId=301864
        public void ConfigureAuth(IAppBuilder app)
        {
            // Configure the db context, user manager and signin manager to use a single instance per request
            app.CreatePerOwinContext(ApplicationDbContext.Create);
            app.CreatePerOwinContext<ApplicationUserManager>(ApplicationUserManager.Create);
            app.CreatePerOwinContext<ApplicationSignInManager>(ApplicationSignInManager.Create);

            // Enable the application to use a cookie to store information for the signed in user
            // and to use a cookie to temporarily store information about a user logging in with a third party login provider
            // Configure the sign in cookie
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Account/Login"),
                Provider = new CookieAuthenticationProvider
                {
                    // Enables the application to validate the security stamp when the user logs in.
                    // This is a security feature which is used when you change a password or add an external login to your account.  
                    OnValidateIdentity = SecurityStampValidator.OnValidateIdentity<ApplicationUserManager, ApplicationUser>(
                        validateInterval: TimeSpan.FromMinutes(30),
                        regenerateIdentity: (manager, user) => user.GenerateUserIdentityAsync(manager))
                }
            });            
            app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

            // Enables the application to temporarily store user information when they are verifying the second factor in the two-factor authentication process.
            app.UseTwoFactorSignInCookie(DefaultAuthenticationTypes.TwoFactorCookie, TimeSpan.FromMinutes(5));

            // Enables the application to remember the second login verification factor such as phone or email.
            // Once you check this option, your second step of verification during the login process will be remembered on the device where you logged in from.
            // This is similar to the RememberMe option when you log in.
            app.UseTwoFactorRememberBrowserCookie(DefaultAuthenticationTypes.TwoFactorRememberBrowserCookie);


            
            app.UseOAuthAuthorizationServer(new OAuthAuthorizationServerOptions
                {
                    AuthorizeEndpointPath = new PathString(Paths.AuthorizePath),
                    TokenEndpointPath = new PathString(Paths.TokenPath),
                    ApplicationCanDisplayErrors = true,
                    #if DEBUG
                        AllowInsecureHttp = true,
                    #endif
                    Provider = new OAuthAuthorizationServerProvider
                        {
                            OnValidateClientRedirectUri = ValidateClientRedirectUri,
                            OnValidateClientAuthentication = ValidateClientAuthentication,
                            OnGrantResourceOwnerCredentials = GrantResourceOwnerCredentials,
                            OnGrantClientCredentials = GrantClientCredentials
                        },
                // The authorization code provider is the object in charge of creating and receiving
                // the authorization code.
                    AuthorizationCodeProvider = new AuthenticationTokenProvider
                        {
                            OnCreate = CreateAuthenticationCode,
                            OnReceive = ReceiveAuthenticationCode,
                        },
                // The refresh token provider is in charge in creating and receiving refresh
                // token.
                    RefreshTokenProvider = new AuthenticationTokenProvider
                        {
                            OnCreate = CreateRefreshToken,
                            OnReceive = ReceiveRefreshToken,
                        }
                });

            //Protect the resources on this server.
            app.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions{});


            // Uncomment the following lines to enable logging in with third party login providers
            //app.UseMicrosoftAccountAuthentication(
            //    clientId: "",
            //    clientSecret: "");

            //app.UseTwitterAuthentication(
            //   consumerKey: "",
            //   consumerSecret: "");

            //app.UseFacebookAuthentication(
            //   appId: "",
            //   appSecret: "");

            //app.UseGoogleAuthentication(new GoogleOAuth2AuthenticationOptions()
            //{
            //    ClientId = "",
            //    ClientSecret = ""
            //});
        }
    }
}