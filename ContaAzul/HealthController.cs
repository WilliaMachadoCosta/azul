using Microsoft.AspNetCore.Mvc;

namespace ContaAzul
{
    [ApiController]
    [Route("[controller]")]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok("Healthy");
        }
    }
}
