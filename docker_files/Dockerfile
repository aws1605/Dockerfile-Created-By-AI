Here is an ideal Dockerfile for a C# .NET Core 3.1 application that follows best practices:

```Dockerfile
# Use an official .NET Core image as our base image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env

# Set the working directory to /app
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# Copy everything else, including .cs files
COPY . .

# Build the application
RUN dotnet build -c Release

# Create a production-ready multi-stage build
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime

# Set working directory to /app
WORKDIR /app

# Copy the compiled application from the previous stage
COPY --from=build-env /app/bin/Release/netcoreapp3.1/your-executable.dll .
COPY --from=build-env /app/*.csproj .

# Run the application
CMD ["dotnet", "your-executable.dll"]
```

Here's what this Dockerfile does:

1. **Base Image**: We start with an official .NET Core SDK image (`mcr.microsoft.com/dotnet/core/sdk:3.1`) which provides the necessary tools for building and compiling our C# application.
2. **Working Directory**: We set the working directory to `/app`, where our application code will reside.
3. **Copying dependencies**: We copy our `.csproj` file and restore the dependencies using `dotnet restore`.
4. **Copying source code**: We copy all other files, including our C# code, into the working directory.
5. **Building the application**: We build our application using `dotnet build -c Release`, which compiles our code in release mode.
6. **Multi-stage build**: We create a new stage based on an official .NET Core ASP.NET image (`mcr.microsoft.com/dotnet/core/aspnet:3.1`). This stage is used to run our application in production.
7. **Copying the compiled application**: We copy the compiled executable from the previous stage into this new stage, so that it can be run at runtime.
8. **Running the application**: Finally, we set the command to run our application using `dotnet your-executable.dll`, where `your-executable` is the name of your executable.

This Dockerfile follows best practices by:

* Using official .NET Core images as base images
* Separating build and runtime stages
* Minimizing the amount of data copied between stages
* Using a consistent naming convention for files and directories

Note that you should replace `your-executable.dll` with the actual name of your executable.