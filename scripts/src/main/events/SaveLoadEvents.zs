import mods.crtultimate.events.server.ServerStartedEvent;
import mods.crtultimate.events.server.ServerStoppedEvent;
import mods.sdmengine.snbt.SNBT;

public class SaveLoadEvents{

    protected static onServerStartedEvent() as void{
        events.register<mods.crtultimate.events.server.ServerStartedEvent>(event => {
            Developers.deserialize();
        });
    }

    protected static onServerStoppedEvent() as void{
        events.register<mods.crtultimate.events.server.ServerStoppedEvent>(event => {
            Developers.serialize();
        });
    }

    public static init() as void{
        onServerStartedEvent();
        onServerStoppedEvent();
    }
}