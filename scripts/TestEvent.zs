import mods.rpgworld.Manager;

events.register<crafttweaker.forge.api.event.interact.RightClickBlockEvent>(event => {
    if(!event.entity.level.isClientSide && event.hand == <constant:minecraft:interactionhand:main_hand>) {
        Manager.openScreen(event.entity);
        //PlayerData.readPlayerInventory(event.entity);
    }
});