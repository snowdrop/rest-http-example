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

import io.openshift.booster.service.GreetingProperties;
import org.junit.Test;

import static com.jayway.restassured.RestAssured.given;
import static com.jayway.restassured.RestAssured.when;
import static org.hamcrest.core.Is.is;

public abstract class AbstractBoosterApplicationTest {

    @Test
    public void testGreetingEndpoint() {
        when().get()
                .then()
                .statusCode(200)
                .body("content", is(String.format(getProperties().getMessage(), "World")));
    }

    @Test
    public void testGreetingEndpointWithNameParameter() {
        given().param("name", "John")
                .when()
                .get()
                .then()
                .statusCode(200)
                .body("content", is(String.format(getProperties().getMessage(), "John")));
    }

    protected abstract GreetingProperties getProperties();

}
