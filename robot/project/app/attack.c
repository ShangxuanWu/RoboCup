#include "attack.h"

#define INF 100000
#define QSIZE GRAPH_POINT_NUM

static uint8 field_sensors[10] = {0};
static int rds[QSIZE], rdt[QSIZE], hds = 0, tls = 0, hdt = 0, tlt = 0;
static int curpnt = 0, nxtpnt = 0;

void restore(){
    while (hds != tls){
        graph_reset_edge_weight(rds[hds], rdt[hdt]);
        hds = (hds+1) % QSIZE;
        hdt = (hdt+1) % QSIZE;
    }
}

void modify(int pn1, int pn2){
    graph_set_edge_weight(pn1, pn2, INF);

    rds[tls] = pn1;
    rdt[tlt] = pn2;
    tls = (tls+1) % QSIZE;
    tlt = (tlt+1) % QSIZE;

    if (tls == hds) { // shouldn't be here!!!
        while (1) {
            int cnt = 1000;
            yesbeep();
            while (cnt--);
            cnt = 1000;
            nobeep();
            while (cnt--);
        }
    }
}

int route(){
    static int dest[2] = {26, 30};
    static int cnt = 0;

    int path1[GRAPH_POINT_NUM], path_size1;
    int path2[GRAPH_POINT_NUM], path_size2;

    int dist1 = graph_spfa(curpnt, 26, path1, &path_size1);
    int dist2 = graph_spfa(curpnt, 30, path2, &path_size2);

    if (dist1 == dist2){
        cnt = (cnt+1) % 2;
        nxtpnt = (cnt == 1 ? path2[1] : path1[1]);
        return dest[cnt];
    }
    else if (dist1 < dist2){
        nxtpnt = path1[1];
        return dest[0];
    }
    else{
        nxtpnt = path2[1];
        return dest[1];
    }
}

ACTOR_CALLBACK_FUNC(attack_actor_callback, p, d){
    static int choice = 0;
    extern long TIME_PASSED;
    curpnt = actor_get_current_point_num();

    if (curpnt == 26 || curpnt == 30)
        while (1) yesbeep();

    get_field_sensors(field_sensors);
    if (field_sensors[8] && curpnt != 28 && choice != 1){
        restore();
        modify(21, 28);
        modify(27, 28);
        modify(29, 28);
        choice = 1;
    }
    else if (field_sensors[7] && curpnt != 24 && choice != 2){
        restore();
        modify(23, 24);
        modify(25, 24);
        choice = 2;
    }
    else if (field_sensors[9] && curpnt != 32 && choice != 3){
        restore();
        modify(31, 32);
        modify(19, 32);
        choice = 3;
    }
    else{
        //restore();
    }

    //if (scan_infront()){
    if (actor_is_car_infront()) {
        restore();
        if (curpnt == 32 || curpnt == 31){
            modify(30, 31);
        }
        else if (curpnt == 24 || curpnt == 25){
            modify(26, 25);
        }
        else
            modify(curpnt, nxtpnt);
        yesbeep();
        choice = 0;
    }
    else
        nobeep();

    *p = route();
    if (TIME_PASSED > 1170 && !actor_is_car_infront()) *p = 16;
}

void attack_init(void) {
	actor_set_callback_func(attack_actor_callback);
	actor_set_autowin(1);
}
