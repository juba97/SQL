using Microsoft.EntityFrameworkCore;
using MyWebAPI.Models;


namespace MyWebAPI.Data
{
    
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) {}

        public DbSet<Product> Products { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    modelBuilder.Entity<Product>()
        .Property(p => p.Price)
        .HasColumnType("decimal(18,2)"); // ან თუნდაც სხვადასხვა precision/scale
}

    }
    
}

