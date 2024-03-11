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

namespace Parameters {
  @friendlyName("team")
  model Team {
    @path @segment("teams") teamId: Id;
  }
  
  @friendlyName("user")
  model User {
    @path @segment("users") userId: Id;
  }

  @friendlyName("actionItem")
  model ActionItem {
    @path @segment("actionitems") actionitemId: Id;
  }
  
  @friendlyName("retro")
  model Retro {
    @path @segment("retros") retroId: Id;
  }

  @friendlyName("thought")
  model Thought {
    @path @segment("thoughts") thoughtId: Id;
  }
  
  alias TeamUser = Team & User;
  alias TeamActionitem = Team & ActionItem;
  alias TeamRetro = Team & Retro;
  alias TeamRetroThought = TeamRetro & Thought;
}
