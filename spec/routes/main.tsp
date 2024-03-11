import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./teams.tsp";
import "./users.tsp";
import "./retros.tsp";
import "./thoughts.tsp";
import "./actionitems.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@format("uuid")
scalar Id extends string;
