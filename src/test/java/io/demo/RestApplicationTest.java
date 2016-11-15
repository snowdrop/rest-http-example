package io.demo;

import io.demo.service.Greeting;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.IntegrationTest;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.client.RestTemplate;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = RestApplication.class)
@WebIntegrationTest("server.port:0")   // Use a random port
public class RestApplicationTest {

    // This will hold the port number the server was started on
    @Value("${local.server.port}")
    int port;

    final RestTemplate template = new RestTemplate();

    @Test
    public void callServiceTest() {
        Greeting message = template.getForObject("http://localhost:" + port + "/greeting",Greeting.class);
        Assert.assertEquals("Hello, World!", message.getContent());
        Assert.assertEquals(1, message.getId());
    }

}
