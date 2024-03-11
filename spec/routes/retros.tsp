import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@resource("retros")
@parentResource(Team)
model Retro {
  @key("retroId") @visibility("read") id: Id;
  name: string;
  metadata?: Record<unknown>;
  completed?: boolean = false;
}

@tag("Retros")
@autoRoute
interface Retros {
  @listsResource(Retro)
  @summary("List retros belonging to the specified team")
  op list(...Parameters.Team): Retro[] | UnauthorizedResponse | NotFoundResponse;

  @createsResource(Retro)
  @summary("Create new retro belonging to the specified team")
  op create(...Parameters.Team, @body retro: Retro): CreatedResponse | UnauthorizedResponse | NotFoundResponse;

  @readsResource(Retro)
  @summary("Retreive a single retro belonging to the specified team")
  op read(...Parameters.TeamRetro): Retro | UnauthorizedResponse | NotFoundResponse;

  @updatesResource(Retro)
  @summary("Update a single retro belonging to the specified team")
  op update(...Parameters.TeamRetro, @body retro: Retro): Retro | UnauthorizedResponse | NotFoundResponse;
}
