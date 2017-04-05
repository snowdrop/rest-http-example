/*
 * Copyright 2016-2017 Red Hat, Inc, and individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.openshift.booster;

import io.openshift.booster.service.Greeting;
import org.junit.Before;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.client.RestTemplate;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class BoosterApplicationTest {

    @Value("${local.server.port}")
    private int port;

    private final RestTemplate template = new RestTemplate();

    private String serviceUrl;

    @Before
    public void beforeTest() {
        serviceUrl = String.format("http://localhost:%d/api/greeting", port);
    }

    @Test
    public void testGreetingEndpoint() {
        Greeting greeting = template.getForObject(serviceUrl, Greeting.class);
        Assert.assertEquals("Hello, World!", greeting.getContent());
    }

    @Test
    public void testGreetingEndpointWithNameParameter() {
        Greeting greeting = template.getForObject(serviceUrl + "?name=John", Greeting.class);
        Assert.assertEquals("Hello, John!", greeting.getContent());
    }

}
