import express from 'express';
import swaggerUi from 'swagger-ui-express';
import fs from 'fs';
import yaml from 'yaml';

const app = express();

function handler(req, _, next) {
  const swaggerFile = fs.readFileSync('./tsp-output/@typespec/openapi3/openapi.yaml', 'utf8');
  req.swaggerDoc = yaml.parse(swaggerFile);
  next();
}

app.use('/', handler, swaggerUi.serve, swaggerUi.setup());

app.listen(3000);
