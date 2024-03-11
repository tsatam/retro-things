import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@tag("Thoughts")
namespace Thoughts {
  model Thought {
    @key @visibility("read") id: Id;
    message: string;
    votes?: integer = 0;
    completed?: boolean = false;

    index?: integer = 0;
  }

  @route("/teams/{teamId}/retros/{retroId}/thoughts")
  namespace ByRetro {
    model Parameters {
      @path @segment("teams") teamId: Id;
      @path @segment("retros") retroId: Id;
    }

   @doc("List all thoughts belonging to the specified retro")
   op list(...Parameters): Thought[];

   @doc("Create a new thought belonging to the specified retro")
   @post op create(...Parameters, @body thought: Thought): Thought;

   @doc("Retrieve a single thought belonging to the specified retro")
   op read(...Parameters, @path id: Id): Thought;

   @doc("Update a single thought belonging to the specified retro")
   @patch op update(...Parameters, @path id: Id, @body thought: Thought): Thought;

   @doc("Increment the vote count on a single thought belonging to the specified retro")
   @put @route("/{id}/vote") op vote(...Parameters, @path id: Id): Thought;

   @doc("Delete a single thought belonging to the specified retro")
   @delete op delete(...Parameters, @path id: Id): Thought;
  }
}
