import crafttweaker.forge.api.event.item.ItemTooltipEvent;
import stdlib.List;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.text.Component;
import crafttweaker.api.data.MapData;
import mods.rpgworld.events.ScreenCloseEvent;
import mods.rpgworld.events.FeatureGenerationEvent;
import mods.rpgworld.events.StructureGenerationEvent;

/*----------------------------------------------------------------
                Класс не определённых событий
------------------------------------------------------------------*/
public class MiscEvents {

    protected static onDifficultSelectedEvent() as void{
        events.register<mods.rpgworld.events.DifficultSelectedEvent>(event => {
            val player = event.entity;
            if(player.level.isClientSide) return;

            var state = PlayerStateMachine.of(player);
            state.generateBaseStats();
            state.syncData();
            if(!("havePlaing" in player.customData)){
                player.updateCustomData({"havePlaing" : true});
            }

            if(Developers.getLevel(player) > 0){
                player.sendMessage(player.customData as string);
                PlayerDataBase.of(player).serialize();
            }

            PlayerPropertyUtils.of(player).run();

            if(Developers.getLevel(player) > 0){
                println(player.customData as string);
            }
        });
    }

    protected static onScreenCloseEvent() as void{
        events.register<mods.rpgworld.events.ScreenCloseEvent>(event => {
            var player = event.entity;
            if(player.level.isClientSide) return;

            var state = PlayerStateMachine.of(player);
            state.generateBaseStats();
            state.syncData();
        });
    }

    protected static onFeatureGenerationEvent() as void{
        events.register<mods.rpgworld.events.FeatureGenerationEvent>(event => {
            var player as Player? = event.player as Player?;
            if(player == null) {
                if(!GenerationControl.isVanilla(event.registry)) event.cancel();
                return;
            }
            if(!GenerationControl.isVanilla(event.registry)) event.cancel();
        });
    }
    protected static onStructureGenerationEvent() as void{
        events.register<mods.rpgworld.events.StructureGenerationEvent>(event => {
            var player as Player? = event.player as Player?;
            if(player == null) {
                if(!GenerationControl.isVanilla(event.registry)) event.cancel();
                return;
            }

            if(!GenerationControl.isVanilla(event.registry)) event.cancel();
        });
    }

    public static init() as void{
        onDifficultSelectedEvent();
        onScreenCloseEvent();
        onFeatureGenerationEvent();
        onStructureGenerationEvent();
    }
}