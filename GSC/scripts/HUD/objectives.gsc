add_new_objective(objective, str_waittill)
{
    self.n_obj_id = gameobjects::get_next_obj_id();
    if (Objective_State(self.n_obj_id) == "empty") {
        Objective_Add(self.n_obj_id, "active", self, objective);
    }
    else {
        Objective_OnEntity(self.n_obj_id, self);
        Objective_SetState(self.n_obj_id, "active");
    }
    function_da7940a3(self.n_obj_id, 1);
    self thread release_obj_on_death(str_waittill);
}

release_obj_on_death(str_waittill)
{
    self util::waittill_any_ents(self, "death", level, "release_objs", self, str_waittill);
    if (IsDefined(self.n_obj_id)) {
        gameobjects::release_obj_id(self.n_obj_id);
        Objective_SetState(self.n_obj_id, "invisible");
    }
}