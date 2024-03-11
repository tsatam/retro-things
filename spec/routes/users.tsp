import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@tag("Users")
namespace Users {
  model User {
    @key id: Id;
  }

  @route("/users")
  @doc("Get current user")
  op read(@path id: Id): User | UnauthorizedResponse | NotFoundResponse;

  @route("/teams/{teamId}/users")
  namespace ByTeam{
    model Parameters {
      @path @segment("teams") teamId: Id;
    }

    @doc("List users of the specified team")
    op list(...Parameters): User[] | UnauthorizedResponse | NotFoundResponse;

    @doc("Add user to the specified team")
    @put op add(...Parameters, @path id: Id): OkResponse | UnauthorizedResponse | NotFoundResponse;

    @doc("Remove user from the specified team")
    @delete op remove(...Parameters, @path id: Id): OkResponse | UnauthorizedResponse | NotFoundResponse;
  }
}
