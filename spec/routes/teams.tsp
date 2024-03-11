import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@route("/teams")
@tag("Teams")
namespace Teams {
  model Team {
    @key @visibility("read") id: Id;
    name: string;
  }

  @doc("List teams the user has access to")
  op list(): Team[] | UnauthorizedResponse;

  @doc("Create a new team")
  @post op create(@body team: Team): CreatedResponse | UnauthorizedResponse;

  @doc("Retrieve a single team")
  op read(@path id: Id): Team | UnauthorizedResponse | NotFoundResponse;

  @doc("Update a single team")
  @patch op update(@path id: Id, @body team: Team): Team | UnauthorizedResponse | NotFoundResponse;
}
