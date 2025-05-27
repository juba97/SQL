using Microsoft.AspNetCore.Mvc;
using MyWebAPI.Data;
using MyWebAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace MyWebAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ProductController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/product
        [HttpGet]
        public IActionResult GetAll()
        {
            return Ok(_context.Products.ToList());
        }

        // GET: api/product/{id}
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var product = _context.Products.FirstOrDefault(p => p.Id == id);
            if (product == null)
            {
                return NotFound("Product not found.");
            }

            return Ok(product);
        }

        // POST: api/product
        [HttpPost]
        public IActionResult Create(Product product)
        {
            _context.Products.Add(product);
            _context.SaveChanges();

            // 201 Created სტატუსი + newly created პროდუქტის URL
            return CreatedAtAction(nameof(GetById), new { id = product.Id }, product);
        }

        // PUT: api/product/5
        [HttpPut("{id}")]
        public IActionResult Update(int id, Product product)
        {
            if (id != product.Id)
            {
                return BadRequest("Product ID mismatch.");
            }

            var existingProduct = _context.Products.FirstOrDefault(p => p.Id == id);
            if (existingProduct == null)
            {
                return NotFound("Product not found.");
            }

            existingProduct.Name = product.Name;
            existingProduct.Price = product.Price;

            _context.SaveChanges();

            return NoContent();
        }
    }
}
