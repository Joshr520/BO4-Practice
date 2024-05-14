override_quest(quest_name, step_name, setup_func, cleanup_func)
{
    while (!IsDefined(level._ee)) {
        waitframe(1);
    }
    while (!IsDefined(level._ee[quest_name])) {
        waitframe(1);
    }

    ee = level._ee[quest_name];
    foreach (step in ee.steps) {
        if (step.name == step_name) {
            ee_step = step;
            break;
        }
    }
    if (!IsDefined(ee_step)) {
        return;
    }

    if (IsDefined(setup_func)) {
        ee_step.setup_func = setup_func;
    }
    if (IsDefined(cleanup_func)) {
        ee_step.cleanup_func = cleanup_func;
    }
}