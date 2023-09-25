FROM microros/base:foxy AS micro-ros-agent-builder

WORKDIR /uros_ws
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
&&  . install/local_setup.sh \
&&  apt update \
&&  ros2 run micro_ros_setup create_agent_ws.sh \
&&  ros2 run micro_ros_setup build_agent.sh 

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \ 
    ros-foxy-realsense2-*

RUN rm -rf /etc/ros/rosdep/sources.list.d/20-default.list
# bootstrap rosdep
RUN rosdep init && \
  rosdep update 

WORKDIR /uros_ws


ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV MICROROS_DISABLE_SHM=1

RUN echo ". /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo ". /uros_ws/install/setup.bash" >> ~/.bashrc

# setup entrypoint
# COPY ./micro-ros_entrypoint.sh /
# ENTRYPOINT ["/bin/sh", "/micro-ros_entrypoint.sh"]
# CMD ["--help"]