import mods.rpgworld.Manager;

events.register<crafttweaker.forge.api.event.interact.RightClickBlockEvent>(event => {
    if(!event.entity.level.isClientSide && event.hand == <constant:minecraft:interactionhand:main_hand>) {
        var data = PlayerStateMachine.of(event.entity);
        // QuestUtils.of(event.entity).setComplete("14E518CE93CC495B");
        // data.unlockMiniMap();
        // data.unlockJade();

        // Manager.sendUnlock(event.entity, "sdm.unlock.skill_tree", "sdm.unlock.skill_tree.description");
        // Manager.sendUnlock(event.entity, "hello", "pososi");
        // Manager.openScreen(event.entity);
        //PlayerData.readPlayerInventory(event.entity);
    }
});