# Running the project
#### Note: This app works alongside with [rest insured](https://github.com/Raifc/rest_insured) app.

1. First, clone and run the [rest insured](https://github.com/Raifc/rest_insured) project.

2. Run the project using the following command:

```bash
docker-compose up --build
```
# About the project
- This project provides GrapqhQL endpoints that are responsible to fetch and create policies. For the creation, it will write a message on a RabbitMQ queue. The rest_insured app will persist the policy as it watches the queue. For fetching policies, it will make a direct GET request to the rest_insured app.
  
# Requests Examples
### Policy Creation
### Fetch Policy
