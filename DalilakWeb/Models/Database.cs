using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Configuration;

namespace DalilakWeb.Models
{
    public class Database : DbContext
    {
        public DbSet<Admin> admin { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseMySQL(ConfigurationManager.ConnectionStrings["Dalilk_connection"].ConnectionString);
        }

    }

    public class Admin
    {
        [Key]
        public string id { get; set; }
        //[Unique]
        public string email { get; set; }
        //[Unique]
        public string password { get; set; }
    }
}