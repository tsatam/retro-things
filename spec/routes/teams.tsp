import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@resource("teams")
model Team {
  @key("teamId") @visibility("read") id: Id;
  name: string;
}

@tag("Teams")
@autoRoute
interface Teams {
  @listsResource(Team)
  @summary("List teams the user has access to")
  list(): Team[] | UnauthorizedResponse;

  @createsResource(Team)
  @summary("Create a new team")
  create(@body team: Team): CreatedResponse | UnauthorizedResponse;

  @readsResource(Team)
  @summary("Retrieve a single team")
  read(...Parameters.Team): Team | UnauthorizedResponse | NotFoundResponse;

  @updatesResource(Team)
  @summary("Update a single team")
  update(...Parameters.Team, @body team: Team): Team | UnauthorizedResponse | NotFoundResponse;
}
