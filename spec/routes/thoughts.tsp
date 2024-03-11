import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@resource("thoughts")
@parentResource(Retro)
model Thought {
  @key("thoughtId") @visibility("read") id: Id;
  message: string;
  votes?: integer = 0;
  completed?: boolean = false;

  index?: integer = 0;
}

@tag("Thoughts")
@autoRoute
interface Thoughts {
  @listsResource(Thought)
  @summary("List all thoughts belonging to the specified retro")
  list(...Parameters.TeamRetro): Thought[];

  @createsResource(Thought)
  @summary("Create a new thought belonging to the specified retro")
  create(...Parameters.TeamRetro, @body thought: Thought): Thought;

  @readsResource(Thought)
  @summary("Retrieve a single thought belonging to the specified retro")
  read(...Parameters.TeamRetroThought): Thought;

  @updatesResource(Thought)
  @summary("Update a single thought belonging to the specified retro")
  update(...Parameters.TeamRetroThought, @body thought: Thought): Thought;

  @updatesResource(Thought) @action("vote") @put
  @summary("Increment the vote count on a single thought belonging to the specified retro")
  vote(...Parameters.TeamRetroThought): Thought;

  @deletesResource(Thought)
  @summary("Delete a single thought belonging to the specified retro")
  delete(...Parameters.TeamRetroThought): Thought;
}
