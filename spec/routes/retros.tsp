import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@tag("Retros")
namespace Retros {
  model Retro {
    @key @visibility("read") id: Id;
    name: string;
    metadata?: Kinds.Metadata;
    completed?: boolean = false;
  }

  namespace Kinds {
    @pattern("#[0-9a-fA-F]{6}")
    scalar Color extends string;

    enum Kind {
      Columns: "columns",
    }
  
    @discriminator("kind")
    union Metadata {
      columns: ColumnsMetadata;
    }
  
    model ColumnsMetadata {
      kind: Kind.Columns;
      columns: {name: string, color: Color}[];
    }
  }

  @route("/teams/{teamId}/retros")
  namespace ByTeam {
    model Parameters {
      @path @segment("teams") teamId: Id;
    }

    @doc("List retros belonging to the specified team")
    op list(...Parameters): Retro[] | UnauthorizedResponse | NotFoundResponse;

    @doc("Create new retro belonging to the specified team")
    @post op create(...Parameters, @body retro: Retro): CreatedResponse | UnauthorizedResponse | NotFoundResponse;

    @doc("Retreive a single retro belonging to the specified team")
    op read(...Parameters, @path id: Id): Retro | UnauthorizedResponse | NotFoundResponse;

    @doc("Update a single retro belonging to the specified team")
    @patch op update(...Parameters, @path id: Id, @body retro: Retro): Retro | UnauthorizedResponse | NotFoundResponse;
  }  
}
