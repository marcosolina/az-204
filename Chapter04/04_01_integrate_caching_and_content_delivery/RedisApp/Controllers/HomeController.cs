﻿using System.Configuration;
using StackExchange.Redis;
using System.Web.Mvc;
using System;

namespace RedisApp.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult RedisCache()
        {
            ViewBag.Message = "A simple example with Azure Cache for Redis on ASP.NET.";
            Lazy<ConnectionMultiplexer> lazyConnection = new Lazy<ConnectionMultiplexer>(() =>
            {
                var tmp = ConfigurationManager.AppSettings["CacheConnection"];
                if(tmp == null)
                {
                    tmp = "az204marcoredis.redis.cache.windows.net:6380,password=E7k+yLgHGO1XirRiG2dbCZXRHZQbsVg54hXDJxlnYPw=,ssl=True,abortConnect=False";
                }
                string cacheConnection = tmp.ToString();
                return ConnectionMultiplexer.Connect(cacheConnection);
            });

            // You need to create a ConnectionMultiplexer object for accessing the Redis
            // cache.
            // Then you can get an instance of a database.
            IDatabase cache = lazyConnection.Value.GetDatabase();

            // Perform cache operations using the cache object...
            // Run a simple Redis command
            ViewBag.command1 = "PING";
            ViewBag.command1Result = cache.Execute(ViewBag.command1).ToString();

            // Simple get and put of integral data types into the cache
            ViewBag.command2 = "GET Message";
            ViewBag.command2Result = cache.StringGet("Message").ToString();

            // Write a new value to the database.
            ViewBag.command3 = "SET Message \"Hello! The cache is working from ASP.NET!\"";
            ViewBag.command3Result = cache.StringSet("Message", "Hello! The cache is working from ASP.NET!").ToString();

            // Get the message that we wrote on the previous step
            ViewBag.command4 = "GET Message";
            ViewBag.command4Result = cache.StringGet("Message").ToString();

            // Get the client list, useful to see if the connection list is growing...
            ViewBag.command5 = "CLIENT LIST";
            ViewBag.command5Result = cache.Execute("CLIENT", "LIST").ToString().Replace("id=", "\rid=");
            lazyConnection.Value.Dispose();
            return View();
        }
    }
}