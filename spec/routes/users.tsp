import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@resource("users")
model User {
  @key("userId") @visibility("read") id: Id;
}

@tag("Users")
@autoRoute
interface Users {
  @readsResource(User)
  @summary("Get current user")
  read(...Parameters.User): User | UnauthorizedResponse | NotFoundResponse;

  @listsResource(User)
  @summary("List users of the specified team")
  listByTeam(...Parameters.Team): User[] | UnauthorizedResponse | NotFoundResponse;

  @updatesResource(User) @put 
  @summary("Add user to the specified team")
  addToTeam(...Parameters.TeamUser): OkResponse | UnauthorizedResponse | NotFoundResponse;

  @updatesResource(User) @delete 
  @summary("Remove user from the specified team")
  removeFromTeam(...Parameters.TeamUser): OkResponse | UnauthorizedResponse | NotFoundResponse;
}
