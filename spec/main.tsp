import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./routes";

using TypeSpec.Http;
using TypeSpec.Rest;

@service({
  title: "Retro Spec";
})
namespace RetroSpec;
