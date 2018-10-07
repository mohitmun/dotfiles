/* cpu_usage
 * Prints virtual cpu usage in tab delimited format
 * Usage: ./cpu_usage
 *
 * Author: Aram Avila-Herrera
 * Date: June 28, 2012
 *
 * Credit: I think I adapted this from a stackoverflow post
 * by user VenoMKO: http://stackoverflow.com/a/6795612
 *
 * License: See LICENSE
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>
#include <unistd.h>
#include <time.h>

int update(float* p_array);

/* this is where host_processor_info saves stuff */
processor_cpu_load_info_t cpuInfo, prevCpuInfo;
mach_msg_type_number_t numCpuInfo, numPrevCpuInfo;
unsigned int numCPUs;

int print_cpu(){
    /* struct required for newfangled nanosleep */
    struct timespec delay, delay2;
    delay.tv_sec = 0;
    delay.tv_nsec = 100000000;

    int update_idx;
    float* p_array = NULL;
    int pidx = 0;

    /* extra call to get numCPUs */
    host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUs, (processor_info_array_t*)&cpuInfo, &numCpuInfo);

    /* store latest value in p_array */
    p_array = calloc(sizeof(float), numCPUs);

    //for (update_idx = 0; update_idx < atoi(argv[1]);update_idx++) {
    for (update_idx = 0; update_idx < 2; update_idx++) {
        /* update cpu usage */
        update(p_array);
        nanosleep(&delay, &delay2);
        //usleep(300000);
    }

    /* print cpu usage */
    printf("Core\tUsage (%%)\n");
    for (pidx = 0; pidx < numCPUs; pidx++) {
        printf("%d\t%.2f\n", pidx, p_array[pidx]);
    }

    /* for completeness :) */
    free(p_array);
    p_array = NULL;

    return 0;
}

int update(float* p_array){
    float inUse, total = 0.0;

    /* get cpu usage info here */
    host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUs, (processor_info_array_t*)&cpuInfo, &numCpuInfo);
    for (int cpuidx = 0; cpuidx < numCPUs; cpuidx++) {
        /* calculate percent used ((user + system + nice) / (user + system + nice + idle) )*/
        if (prevCpuInfo) {
            inUse = (
                     (cpuInfo[cpuidx].cpu_ticks[CPU_STATE_USER]   - prevCpuInfo[cpuidx].cpu_ticks[CPU_STATE_USER]) +
                     (cpuInfo[cpuidx].cpu_ticks[CPU_STATE_SYSTEM] - prevCpuInfo[cpuidx].cpu_ticks[CPU_STATE_SYSTEM]) +
                     (cpuInfo[cpuidx].cpu_ticks[CPU_STATE_NICE]   - prevCpuInfo[cpuidx].cpu_ticks[CPU_STATE_NICE])
                     );
            total = inUse + (cpuInfo[cpuidx].cpu_ticks[CPU_STATE_IDLE] - prevCpuInfo[cpuidx].cpu_ticks[CPU_STATE_IDLE]);
        } else {
            inUse = cpuInfo[cpuidx].cpu_ticks[CPU_STATE_USER] + cpuInfo[cpuidx].cpu_ticks[CPU_STATE_SYSTEM] + cpuInfo[cpuidx].cpu_ticks[CPU_STATE_NICE];
            total = inUse + cpuInfo[cpuidx].cpu_ticks[CPU_STATE_IDLE];
        }

        p_array[cpuidx] = 100*inUse/total; /* store it */
    }

    if (prevCpuInfo) {
        /* catch memory leaks */
        size_t prevCpuInfoSize = sizeof(integer_t) * numPrevCpuInfo;
        vm_deallocate(mach_task_self(), (vm_address_t)prevCpuInfo, prevCpuInfoSize);
    }
    prevCpuInfo = cpuInfo;
    numPrevCpuInfo = numCpuInfo;


    cpuInfo = NULL;
    numCpuInfo = 0;

    return 0;
}
