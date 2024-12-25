# 25.12.2024
# Курс "Микросервисы и контейнеризация"

>Уважаемые студенты!
>
>Для полноценного участия в курсе "Микросервисная архитектура и контейнеризация" просим вас зарегистрироваться на платформе https://mcs.mail.ru. Регистрация должна быть сделана с той же почты, на которую зарегистрирован ваш аккаунт на GeekBrains.
>
>После регистрации на платформе для начисления квот необходимо нажать кнопку «включить сервисы», а затем написать на support@mcs.mail.ru и сообщить, что вы учитесь в GeekBrains на курсе "Микросервисная архитектура и контейнеризация».

Практика и домашние задания находятся в соответсвующих директориях.

## Полезные ссылки

- [Лекция 1. Микросервисы и контейнеры](#лекция-1-микросервисы-и-контейнеры)
- [Лекция 2. Docker](#лекция-2-docker)
- [Лекция 3. Введение в Kubernetes](#лекция-3-введение-в-kubernetes)
- [Лекция 4. Хранение данных и ресурсы](#лекция-4-хранение-данных-и-ресурсы)
- [Лекция 5. Сетевые абстракции Kubernetes](#лекция-5-сетевые-абстракции-kubernetes)
- [Лекция 6. Устройство кластера](#лекция-6-устройство-кластера)
- [Лекция 7. Продвинутые абстракции](#лекция-7-продвинутые-абстракции)
- [Лекция 8. Деплой тестового приложения в кластер, CI/CD](#лекция-8-деплой-тестового-приложения-в-кластер)

## Лекция 1. Микросервисы и контейнеры

**Перед второй лекцией нужно установить Docker**

Вы можете [установить Docker](https://docs.docker.com/get-docker/) на свой компьютер или виртуальную машину с Linux.

А так же использовать онлайн сервисы, чтобы немедленно приступить к обучению:

🔹 [Play with Docker](https://labs.play-with-docker.com/)

**Паттерны проектирования**

🔹 [The Twelwe-Factor App](https://12factor.net/ru/)

🔹 [GRASP](https://ru.wikipedia.org/wiki/GRASP)

📚 [Чистая архитектура. Искусство разработки программного обеспечения](https://habr.com/ru/company/piter/blog/353170/)

📚 [System Design - Подготовка к сложному интервью](https://habr.com/ru/company/piter/blog/598791/)

**Механизмы контейнеризации**

🔹 [Linux-контейнеры: изоляция как технологический прорыв](https://habr.com/ru/company/redhatrussia/blog/352052/)

🔹 [Namespaces](https://habr.com/ru/company/selectel/blog/279281/)

🔹 [Cgroups](https://habr.com/ru/company/selectel/blog/303190/)

🔹 [Capabilities](https://k3a.me/linux-capabilities-in-a-nutshell/)

🎥 [Могут ли контейнеры быть безопасными?](https://habr.com/ru/company/oleg-bunin/blog/480630/)

**Различные Container Runtime**

🔹 [Различия между Docker, containerd, CRI-O и runc](https://habr.com/ru/company/domclick/blog/566224/)

## Лекция 2. Docker

**Docker**

🔹 [Сеть контейнеров — это не сложно](https://habr.com/ru/company/timeweb/blog/558612/)

🔹 [Overview of Docker CLI](https://docs.docker.com/engine/reference/run/)

🔹 [10 команд для Docker, без которых вам не обойтись](https://tproger.ru/translations/top-10-docker-commands/)

🔹 [Как начать использовать Docker в своих проектах](https://tproger.ru/translations/how-to-start-using-docker/)

🔹 [50 вопросов по Docker, которые задают на собеседованиях, и ответы на них](https://habr.com/ru/company/southbridge/blog/528206/)

**Dockerfile**

🔹 [20 лучших практик по работе с Dockerfile](https://habr.com/ru/company/domclick/blog/546922/)

🔹 [ENTRYPOINT vs CMD: назад к основам](https://habr.com/ru/company/southbridge/blog/329138/)

🔹 [ADD vs COPY](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy)

🔹 [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

🔹 [Use multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)

🔹 [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy%23add-or-copy)

**Docker Compose**

🔹 [Overview of docker-compose CLI](https://docs.docker.com/compose/reference/)

🔹 [Quickstart: Compose and Django](https://docs.docker.com/samples/django/)

🔹 [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)

🔹 [Compose file version 2 reference](https://docs.docker.com/compose/compose-file/compose-file-v2/)

## Лекция 3. Введение в Kubernetes

>Уважаемые студенты, просьба по возможности до начала занятия поставить себе утилиту для работы с Kubernetes – kubectl.
>Это можно сделать по инструкциям из официальной документации для вашей ОС.
>https://kubernetes.io/docs/tasks/tools/install-kubectl/

Делаем работу с kubectl удобнее:

🔹 [kubectl auto-complition](https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/)

🔹 [kubectl aliases](https://github.com/adterskov/kubectl-aliases)

🔹 [kubecolor - раскрашивает вывод kubectl](https://github.com/dty1er/kubecolor/)

🔹 [kubens - быстрый способ переключения между namespaces в kubectl](https://github.com/ahmetb/kubectx/)

Как получить в своё распоряжение полноценный кластер Kubernetes?

**Онлайн сервисы, чтобы немедленно приступить к обучению**

🔹 [Play with Kubernetes](https://labs.play-with-k8s.com/)

**Запустить локальный кластер Kubernetes**

🔹 [Minikube](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

🔹 [Minishift (OpenShift)](https://www.okd.io/minishift/)

🔹 [KiND](https://kind.sigs.k8s.io/docs/user/quick-start/)

🔹 [Docker Desktop](https://docs.docker.com/desktop/kubernetes/)

**Запустить кластер Kubernetes в облаке**

🔹 [Google Cloud Platform (300$ на счет за регистрацию)](https://cloud.google.com/free)

🔹 Российские облачные провайдеры Yandex и MCS (mail.ru) периодически дают бонусы на счет, например за прохождение вебинаров

**Установить кластер самостоятельно**

🔹 [Установка в помощью kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)

🔹 [Установка с помощью kubesparay](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)

## Лекция 4. Хранение данных и ресурсы

🔹 [Динамическое выделение дисков с PVC](https://mcs.mail.ru/help/ru_RU/k8s-pvc/k8s-pvc)

🔹 [Рациональное использование ресурсов в Kubernetes](https://habr.com/ru/company/timeweb/blog/560670/)

🔹 [Как оптимизировать ограничения ресурсов Kubernetes](https://habr.com/ru/company/timeweb/blog/562500/)

## Лекция 5. Сетевые абстракции Kubernetes

🔹 [Configure Liveness, Readiness and Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes)

🔹 [iptables: How Kubernetes Services Direct Traffic to Pods](https://dustinspecker.com/posts/iptables-how-kubernetes-services-direct-traffic-to-pods/)

🔹 [NetworkPolicy Editor](https://cilium.io/blog/2021/02/10/network-policy-editor?utm_source=telegram.me&utm_medium=social&utm_campaign=cilium-predstavil-vizualnyy-redaktor-se)

🔹 [NGINX Ingress Controller Annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/)

## Лекция 6. Устройство кластера

🔹 [Kubernetes is so Simple You Can Explore it with Curl](https://blog.tilt.dev/2021/03/18/kubernetes-is-so-simple.html)

🔹 [Как увеличить скорость реакции Kubernetes на отказ узлов кластера?](https://habr.com/ru/company/timeweb/blog/561084/)

## Лекция 7. Продвинутые абстракции

🎥 [Митап "Stateful-приложения в 2020 году"](https://www.youtube.com/watch?v=ykIh4-616Ic&list=PL8D2P0ruohODzihD0D0FZXkVHXtXbb6w3&index=4&ab_channel=HighLoadChannel)

🎥 [Заделываем дыры в кластере Kubernetes](https://www.youtube.com/watch?v=Ik7VqbgpRiQ&ab_channel=DevOpsChannel)

🔹 [Jobs & Cronjobs in Kubernetes Cluster](https://medium.com/avmconsulting-blog/jobs-cronjobs-in-kubernetes-cluster-d0e872e3c8c8)

🔹 [Tоп-10 PromQL запросов для мониторинга Kubernetes](https://habr.com/ru/company/timeweb/blog/562374/)

## Лекция 8. Деплой тестового приложения в кластер

🔹 [Антипаттерны деплоя в Kubernetes. Часть 1](https://habr.com/ru/company/timeweb/blog/557320/)

🔹 [Антипаттерны деплоя в Kubernetes. Часть 2](https://habr.com/ru/company/timeweb/blog/560772/)

🔹 [Антипаттерны деплоя в Kubernetes. Часть 3](https://habr.com/ru/company/timeweb/blog/561570/)

📚 [ПРОЕКТ «ФЕНИКС». КАК DEVOPS УСТРАНЯЕТ ХАОС И УСКОРЯЕТ РАЗВИТИЕ КОМПАНИИ](https://bombora.ru/book/64983/#.)
